public class AccountsController{
 @AuraEnabled
 public static List<Account> getAccounts(){
     return [Select Id, Name, Industry from Account Order by Createddate Asc];
	 //Testing 1234
 }
}