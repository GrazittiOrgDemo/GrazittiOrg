/*Whenver new Acc is Created with ARR more than 50,000, Add Surbhi as Contact Name

Object - Account, 
Event - After
DML - insert
*/

trigger AccountARR on Account (after Insert) {
    List<Contact> conList = new List<Contact>();
    for(Account a : Trigger.new){
        If(a.ARR__c >= 50000){
            Contact c = new Contact();
            c.AccountID = a.Id;
            c.FirstName = 'Surbhi';
            c.LastName = 'Malhotra';
            
            conList.add(c);
			//Testing
        }
    }
    
    
        insert conList;
}