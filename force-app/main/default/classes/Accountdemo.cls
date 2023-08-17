public with sharing class Accountdemo {
    @AuraEnabled(cacheable=true)
    public static List<Contact> findContactByAccountId(string accountId){
        return [
            SELECT Id, FirstName,LastNAme,Email,Phone
            FROM Contact
            WHERE AccountId=:accountId
           //test
           //class
            LIMIT 10];
    }
}