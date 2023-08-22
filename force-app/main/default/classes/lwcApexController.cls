public with sharing class lwcApexController {

@AuraEnabled
public static OpportunityLineItem insertAccountMethod(OpportunityLineItem accountObj){
try {
insert accountObj;
//test
return accountObj;
} catch (Exception exp) {
throw new AuraHandledException(exp.getMessage());
}
}
}