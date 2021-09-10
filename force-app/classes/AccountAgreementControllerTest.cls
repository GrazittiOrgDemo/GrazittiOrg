@isTest
private class AccountAgreementControllerTest {
    
	private static testMethod void testWithOutMSA() {
        Account acc = TestAccount.basic();
        insert acc;
        test.startTest();
        AccountAgreementController.createAgreement(acc.Id);
        System.assertNotEquals(null, acc.Id);
        test.stopTest();
	}

    private static testMethod void testWithMSA() {
        Account acc = TestAccount.basic();
        insert acc;
        Apttus__APTS_Agreement__c agrmnt = new Apttus__APTS_Agreement__c();
        agrmnt.Name = 'MSA' +' Agreement for '+ Acc.Name;
        agrmnt.Apttus__Status_Category__c = 'Request';
        agrmnt.Apttus__Requestor__c = UserInfo.getUserId();
        agrmnt.Apttus__Account__c = acc.Id;
        agrmnt.Yext_Is_Primary_Agreement__c = true;
        insert agrmnt;
        List<RecordType> rtListAgreement = [SELECT ID FROM RecordType WHERE SobjectType = 'Apttus__APTS_Agreement__c' AND Name = 'MSA'];
        Apttus__APTS_Agreement__c agreement = TestAgreement.basic();
        System.assertNotEquals(null, agrmnt.Id);
        insert agreement; 
    }
    
    private static testMethod void testWithSS() {
        
        Account objacc = YEXT_TestDataFactory.getAccount();
        objacc.name = 'unique';
        insert objacc;
        
        Id entLCrecordId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('ENT_Opportunity_Location_Cloud').getRecordTypeId(); 
        Id ssRecordTypeId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByDeveloperName().get('Subscription_Schedule').getRecordTypeId(); 
        
        Id pricebookId = Test.getStandardPricebookId();
        Opportunity objOpp = YEXT_TestDataFactory.getOpportunity();
        objOpp.AccountId = objacc.id;
        objOpp.Pricebook2Id = pricebookId;
        objOpp.Yext_Contract_Version__c = 'Standard';
        objOpp.TCV__c = 15000;
        objOpp.RecordTypeId = entLCrecordId;
        insert objOpp;
        
        Contact objCon = YEXT_TestDataFactory.getContact(objacc);
        insert objCon;
        
        Product2 objProd = YEXT_TestDataFactory.getProduct();
        insert objProd;
        
        SBQQ__Quote__c objQuote = YEXT_TestDataFactory.getQuote();
        objQuote.SBQQ__Account__c = objAcc.Id;
        objQuote.SBQQ__Opportunity2__c   = ObjOpp.Id;
        objQuote.SBQQ__Primary__c   = true;
        objQuote.yext_Payment_Options__c   = 'Credit Card';
        insert objQuote;
        
        Apttus__APTS_Agreement__c agg = new Apttus__APTS_Agreement__c();
        agg.Apttus__Account__c=objacc.id;
        agg.Apttus__Related_Opportunity__c = ObjOpp.id;
        agg.Yext_Quote__c=objQuote.id;
        agg.Yext_Is_Primary_Agreement__c = TRUE;
        agg.Master_Agreement_Date__c = Date.Today();
        agg.RecordTypeId = ssRecordTypeId;
        insert agg;
        
        test.startTest();
        AccountAgreementController.createAgreement(objacc.Id);
        System.assertNotEquals(null, objacc.Id);
        test.stopTest();
  
    }
}