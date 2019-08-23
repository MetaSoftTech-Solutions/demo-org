trigger duplicateDealPreventer on Deal__c (before insert) {
    Map<string, Deal__c> dealMap = new Map<string, Deal__c>();
    for(Deal__c deal: System.Trigger.new){
    	if(deal.Name != null && 
    		(System.Trigger.isInsert || 
    			(deal.Name != System.Trigger.oldMap.get(deal.Id).Name))){
    				if(dealMap.containsKey(deal.Name)){
    					deal.Name.addError('Another new deal has the same title');
    				}else{
    					dealMap.put(deal.Name, deal);
    				}
    			} 
    }
    
    for(Deal__c deal: [SELECT Name from Deal__c WHERE Name IN: dealMap.KeySet()]){
    	Deal__c newDeal = dealMap.get(deal.Name);
    	newDeal.Name.addError('Deal already exists');    	
    }
    
}