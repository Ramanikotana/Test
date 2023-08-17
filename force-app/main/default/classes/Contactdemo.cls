public with sharing class Contactdemo {
    public String accountId{get;set;}
    public Account actObj{get;set;}
    public Contactdemo() {
        actObj = new Account();
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [select Id,type,phone,industry from Account limit 10];
    }
    @auraEnabled
    public static List<Account> getAccountRecordsList(){
        return [select id,name,type,phone,industry from Account limit 10];
    }
    public pageReference retrieveAccountDetail(){
        if(accountId!=null){
            actObj = [select id,name,type,phone,industry from Account where id=:accountId];
        }
        return null;
    }
}