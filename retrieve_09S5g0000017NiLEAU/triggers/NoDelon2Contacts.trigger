/*Prevent Acc from Deleting if it has more than 2 contacts
Object - Acc,
Event - before
DML - Delete
*/
trigger NoDelon2Contacts on Account ( before Delete) {
    Set<Id> accIdset = new Set<Id>();
    Map<Id,List<Contact>> accMap = new Map<Id,List<Contact>>();
    
    //get
    //put
    //containskey
    
    
    List<Account> accList = new List<Account>();
    
    
    
    for(Account a : Trigger.old){
        accIdset .add(a.Id);
    }
    
    accList = [Select id, (Select id from Contacts) from Account where Id=: accIdset ];
    
    
    
    if(accList.size()>0 && !accList.isEmpty()){
        for(Account a : accList){
            accMap.put(a.Id, a.contacts);
        }
    }
    
    
    for(Account a1 : Trigger.old){
       
        if(!accMap.isempty()&& accMap.get(a1.Id).size()>=2 )
            a1.addError('You do not have permission to Delete Accounts which have 2 or more than 2 Contacts');
           
    }
    
}