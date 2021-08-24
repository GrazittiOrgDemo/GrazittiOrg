public with sharing class AccountController {
	//SAMPLE1234
    @AuraEnabled(cacheable=FALSE)
    public static List<Account> findAccounts(String searchKey) 
	{
		//sample
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }
}