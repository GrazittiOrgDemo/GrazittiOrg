public with sharing class AccountController {
	//testing123
    @AuraEnabled(cacheable=False)
    public static List<Account> findAccounts(String searchKey) 
	{
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }
}