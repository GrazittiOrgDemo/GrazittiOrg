/*Whenever Phone field is updated in Accounts, Name should be updated with Name and Phone
Which Object - Account
Which Event - Before
Which DML - Update
Logic - Check Phone field is updated or not - OldMap
*/
trigger AccountTriggerName on Account (before Update) {

    for(Account acc : Trigger.new){
        If(acc.Phone!= Trigger.oldMap.get(acc.ID).phone){
            acc.Name = acc.Name + acc.Phone;
        }
        
    }
    
        

}