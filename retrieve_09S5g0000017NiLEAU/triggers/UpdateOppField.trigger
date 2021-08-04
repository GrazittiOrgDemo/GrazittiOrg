/*Update a field to Opp when the same field is updated on Account
*/
trigger UpdateOppField on Account (after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    List<Opportunity> OpsToBeUpdated= new List<Opportunity>();
    Set<Id> Accountid = new Set<Id>();
    for(Account a : Trigger.new){
        
        if(a.billingcity!=Trigger.oldmap.get(a.Id).billingcity){
            Accountid.add(a.Id);
        }
    }
    
    oppList = [Select Id, AccountId, name, City__c from Opportunity where AccountId =: Accountid];
    for(Opportunity o : oppList){
        o.City__c= trigger.newmap.get(o.AccountId).billingcity;
    }
    
        update oppList ;
}