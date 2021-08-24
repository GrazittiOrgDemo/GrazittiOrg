public with sharing class AccountController {
	//SAMPLE112222222
    @AuraEnabled(cacheable=false)
    public static List<Account> findAccounts(String searchKey) 
	{
		//sample
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }
}