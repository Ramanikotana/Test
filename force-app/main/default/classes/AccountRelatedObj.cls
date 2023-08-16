public with sharing class AccountRelatedObj {
    @auraEnabled
    public static List<Contact> getContacts(Object accountRecId){
        Id accountId=Id.valueOf(String.valueOf(accountRecId).replace('(','').replace(')',''));
        List<Contact> conList = new  List<Contact>();
        String strObjName = accountId.getSObjectType().getDescribe().getName();
        if(strObjName=='Account'){
        conList=[SELECT Id,LastName,AccountId,Name FROM Contact WHERE AccountId=:accountId];
        }else{
           return null; 
        }
        return conList;
    }
   @auraEnabled
    public static List<OpportunityLineItem> getOpportunityListItems(Object OppRecId){
        Id OpportunityId=Id.valueOf(String.valueOf(OppRecId).replace('(','').replace(')',''));
        List<OpportunityLineItem> OppList = new  List<OpportunityLineItem>();
        //List<Opportunity> oppsId = new List<Opportunity>();
        //oppsId = [Select id,AccountId from Opportunity where AccountId=:accountId];
        String strObjName = OpportunityId.getSObjectType().getDescribe().getName();
        if(strObjName=='Opportunity'){
        OppList=[SELECT Id,Name,Quantity,UnitPrice,OpportunityId,Product2.Name FROM OpportunityLineItem WHERE OpportunityId=:OpportunityId order by Createddate desc];
        }else{
           return null;
        }
        return OppList;
    }
    
    @auraEnabled(Cacheable=false)
    public static Boolean getOpportunityListItems1(Object OppLineId){
        system.debug('Entered inside delete');
        Id OpportunityLineItemsId=Id.valueOf(String.valueOf(OppLineId).replace('(','').replace(')',''));
        List<OpportunityLineItem> OppList = new  List<OpportunityLineItem>();
        OppList=[SELECT Id,Name,Quantity,UnitPrice,OpportunityId,Product2.Name FROM OpportunityLineItem WHERE Id=:OpportunityLineItemsId Limit 1];
        System.debug('Opp List is '+OppList);
        try{
        database.delete(OppList);
            return true;
        }catch(Exception ex){
            system.debug('Error message is '+ex.getMessage());
        }
        return false;
        }
         
    @auraEnabled(Cacheable=false)
    public static List<OpportunityLineItem> updateOpportunityListItems(Id OppLineId,Id Product2Id,Decimal Quantity,Decimal UnitPrice){
        System.debug('oppLineId is '+OppLineId);
        System.debug('oppLineId2 is '+Product2Id);
        System.debug('oppLineId3 is '+Quantity);
        System.debug('oppLineId4 is '+UnitPrice);
        system.debug('Entered inside Update');
        /*Id OpportunityLineItemsId=Id.valueOf(String.valueOf(OppLineId).replace('(','').replace(')',''));
        Id Product2=Id.valueOf(String.valueOf(OppLineId).replace('(','').replace(')',''));
        Decimal Quantitys= Decimal.valueOf(Quantity).replace('(','').replace(')','');*/
        
        List<OpportunityLineItem> OppList = new  List<OpportunityLineItem>();
        OppList=[SELECT Id,Name,Quantity,UnitPrice,OpportunityId,Product2.Name FROM OpportunityLineItem WHERE Id=:OppLineId Limit 1];
        System.debug('Opp List is '+OppList);
        try{
            for(OpportunityLineItem opplineItem:OppList){
            opplineItem.Quantity=Quantity;
            //opplineItem.Product2Id=Product2Id;
              opplineItem.UnitPrice=UnitPrice;   
                }
        database.update(OppList);
            return OppList;
        }catch(Exception ex){
            system.debug('Error message is '+ex.getMessage());
        }
        return null;
        }
    
    @auraEnabled(Cacheable=false)
    public static Boolean deleteOpportunityListItems(List<Id> selectedoppids){
        System.debug('selectedoppids is in method '+selectedoppids);
        List<OpportunityLineItem> OppList = new  List<OpportunityLineItem>();
        for(Id OpportunityLineItem:selectedoppids){
            OpportunityLineItem oppid = new OpportunityLineItem();
            oppid.id=OpportunityLineItem;
            OppList.add(oppid);
        }
        try{
            database.delete(OppList);
             return true;
        }catch(Exception ex){
            system.debug('Error message is '+ex.getMessage());
        }
        return false;
        
    }
        
    }