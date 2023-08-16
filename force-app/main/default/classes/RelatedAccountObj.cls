public class RelatedAccountObj {
    @auraEnabled
    public static List<Contact> getContacts(Object relatedAccId){
        Id accountId=Id.valueOf(String.valueOf(relatedAccId).replace('(','').replace(')',''));
        List<Contact> conList = new  List<Contact>();
        String strObjName = accountId.getSObjectType().getDescribe().getName();
        if(strObjName=='Account'){
        conList=[SELECT Id,LastName,AccountId FROM Contact WHERE AccountId=:accountId];
        }else{
           return null; 
        }
        return conList;
    }
}