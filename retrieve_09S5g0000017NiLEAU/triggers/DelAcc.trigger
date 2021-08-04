/*The Trigger will prevent the Users from Deleting the Account, This is because Sys
Admin has all the permissions, we cannot change the permissions
Object - Acc,
Event - before,
DML - Delete
*/

trigger DelAcc on Account (before Delete) {
    for(Account a : trigger.old){
        a.addError('You do not have this permission');
    }

}