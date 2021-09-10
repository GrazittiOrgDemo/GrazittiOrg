/*******************************************************************************************
 * @Name         AccountAgreementController
 * @Author       Saikat Sakar
 * @Date         6/24/2016
 * @Description  Apex Controller for createMsaAura.cmp
 * @Test         AccountAgreementControllerTest
 ******************************************************************************************
 Modification Log :
 Pranjal     01/22/2021        Updated Comments and Description
 Palak		 14/04/2021		   CPQ3-40 - Updated code to populate currency from Account
 *******************************************************************************************/

global class AccountAgreementController{
    public static Account acc;
	public static Id ssLockedRecordTypeId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByDeveloperName().get('Yext_SS_Locked_Agreement').getRecordTypeId();
    public static Id msaLockedRecordTypeId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByDeveloperName().get('Yext_MSA_Locked_Agreement').getRecordTypeId();
    public static Id msaRecordTypeId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByDeveloperName().get('MSA').getRecordTypeId();
    public static Id ssRecordTypeId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByDeveloperName().get('Subscription_Schedule').getRecordTypeId(); 
    
    /**************************************************************************************
    * @Description  This method is called when the 'Create MSA' button is pressed on Account 
	 				Page Layout
    * @Event        Button click
    * @Author       Saikat Sakar / Pranjal Samuel
    **************************************************************************************/
    
    webservice static String createAgreement(String accountId){
        acc = [SELECT Id,Name,CurrencyIsoCode FROM Account WHERE Id =:accountId];
        
		List<Apttus__APTS_Agreement__c> lstExistingSSAgreements = [SELECT Id, Name, RecordTypeId,Yext_Is_Primary_Agreement__c,Apttus__Account__c,Quote__C,Yext_Quote__c FROM Apttus__APTS_Agreement__c where 
		(RecordTypeId =: ssRecordTypeId OR RecordTypeId =: ssLockedRecordTypeId) and Apttus__Account__c =:accountId and quote__C=null];
        
        Apttus__APTS_Agreement__c agrmnt = new Apttus__APTS_Agreement__c();
        //Substring condition Added by Akshansh for Action item 322
        String trimAccName = Acc.Name.length() > 52 ? Acc.Name.substring(0, 52): Acc.Name;
        agrmnt.Name = 'MSA' +' Agreement for '+ trimAccName;
        agrmnt.Apttus__Status_Category__c = 'Request';
        agrmnt.Apttus__Requestor__c = UserInfo.getUserId();
        agrmnt.Apttus__Account__c = accountId;
        agrmnt.RecordTypeId = msaRecordTypeId;
        //CPQ3-40 - Updated code to populate currency from Account
        agrmnt.Master_Agreement_Date__c = System.today();
        agrmnt.CurrencyIsoCode = acc.CurrencyIsoCode;
		
		Map<Id, List<Apttus__APTS_Agreement__c>> mapQuoteVsAgreement = new Map<Id, List<Apttus__APTS_Agreement__c>>();
		if(lstExistingSSAgreements.size() > 0){
			for(Apttus__APTS_Agreement__c ssAgreement: lstExistingSSAgreements){
				if(!mapQuoteVsAgreement.containsKey(ssAgreement.Yext_Quote__c)){
					List<Apttus__APTS_Agreement__c> lstSSAgreement = new List<Apttus__APTS_Agreement__c>();
					if(ssAgreement.Yext_Is_Primary_Agreement__c ==  true){
						lstSSAgreement.add(ssAgreement);
					}
					mapQuoteVsAgreement.put(ssAgreement.Yext_Quote__c, lstSSAgreement);
				}
				else{
					if(ssAgreement.Yext_Is_Primary_Agreement__c ==  true){
						mapQuoteVsAgreement.get(ssAgreement.Yext_Quote__c).add(ssAgreement);
					}
				}
			}
		}
		
		if(mapQuoteVsAgreement.size() > 0){
			for(Id quoteId: mapQuoteVsAgreement.keySet()){
				List<Apttus__APTS_Agreement__c> lstSSAgreement = mapQuoteVsAgreement.get(quoteId);
				if(lstSSAgreement.size() == 0){
                    return null;
				}
			}
		}
        
        insert agrmnt;
        return agrmnt.Id;
        
    }
    
}