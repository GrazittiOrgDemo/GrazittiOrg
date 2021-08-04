/*Create Related Contact when Account is Created
Which Object? - Account
Which Event? - After
What DML? - Insert

NOTE - When we have 2 objects involved, we go for After Event
We put DML outside the FOR loop to avoid hitting limits
*/

trigger AccountTrigger on Account (after Insert) {
    List<Contact> cntList = new List<Contact>();

    for(Account a : Trigger.new){
        System.debug('Trigger.New List'+Trigger.New);
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName= a.Name;
        c.phone = a.phone;
        c.Email= 'malhotrasurbhi16@yahoo.com';
        cntList.add(c);
    }
    
    if(cntList.size()>0)
        insert cntList;

}