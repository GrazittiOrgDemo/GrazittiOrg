public with sharing class AccountController {
<<<<<<< HEAD
	//testing
    @AuraEnabled(cacheable=False)
    public static List<Account> findAccounts(String searchKey) {
=======
	//testing1234
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) 
	{
>>>>>>> 809f1e4 (Testing)
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }

}