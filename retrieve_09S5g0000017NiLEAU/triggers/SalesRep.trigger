trigger SalesRep on Account (before insert, before update) {

    Set<Id> AccOwnerIds = new Set<Id>();
    
    for(Account a : Trigger.new){
        AccOwnerIds.add(a.OwnerId);
    }
    
  Map<Id,User> UserMap = new Map<Id,User>([Select name from User where Id =: AccOwnerIds]);
  
  for(Account a : Trigger.new){
      User usr = UserMap.get(a.OwnerId);
      a.Sales_Rep__c= usr.Name;
  }

}