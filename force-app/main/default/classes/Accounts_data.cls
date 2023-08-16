public with sharing class Accounts_data {
    @AuraEnabled (cacheable = true)
    public static List<Account> getAccounts ( ){
        return [

                 select id,Name,CreatedDate,owner_name__c,Active__c from Account WITH SECURITY_ENFORCED];
    }

}