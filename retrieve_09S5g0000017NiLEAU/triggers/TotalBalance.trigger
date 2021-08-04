/*Write a Trigger to equally divide the amount stored in Custom Field Balance__c of Accounts
to individual balance__c field of associated Accounts
Balance__c == Accounts
Individual Balance__c = Contacts

Create the List
Iterate on Contacts
*/

trigger TotalBalance on Account ( after update) {
    List<Account> accList =  [Select Id, name, Balance__c, (Select id, Individual_Balance__c from Contacts) from Account where Balance__c > 0];
    List<Contact> conList = new List<Contact>();
    Map<Id,Account> accMap = new Map<Id,Account>();
    
    for(Account a : accList ){
        accMap.put(a.Id,a);
    }
    
    System.debug('AccountMap'+accMap);
    
    if(!accMap.isEmpty()){
        for(Account a : accList){
            for(Contact c : accMap.get(a.Id).contacts)
            {
                c.Individual_Balance__c = a.Balance__c/a.contacts.size();
                system.debug(c.Individual_Balance__c);
                conList.add(c);
                
            }
        
        
        }
    }
    
  
    
    
   /* for(Account a : accList ){
        if(a.contacts.size() >0){
            Decimal storeAmount= a.Balance__c/a.contacts.size();
            system.debug(storeAmount);
        }
        
        for(Contact c : a.Contacts){
            if(a.contacts.size() >0){
                c.Individual_Balance__c = a.Balance__c/a.contacts.size();
                system.debug(c.Individual_Balance__c);
                conList.add(c);
            }
        }
    }*/
    
    
    
    if(conList.size()>0 && !conList.isEmpty())
    update conList;

}