trigger AssetTrigger on Asset (after update) {
    system.debug('Inside Asset after update trigger');
    List<Id> assetList = new List<Id>();   
    
    for (Sobject sObj : Trigger.new) {
        Asset newAsset = (Asset) sObj;
        system.debug('Asset Status = ' + newAsset.Status);
        if(newAsset.Status == 'Normal'){            
        	assetList.add(newAsset.Id);
            system.debug('AssetList = ' + assetList);
			List<DrainFlowControl__e> dfEvents = new List<DrainFlowControl__e>();
            dfEvents.add(new DrainFlowControl__e(DeviceSerialNumber__c = newAsset.DeviceSerialNumber__c, SwitchOn__c = false));
            EventBus.publish(dfEvents);            
        }else if(newAsset.status == 'Warning' || newAsset.Status == 'Critical'){
            List<DrainFlowControl__e> dfEvents = new List<DrainFlowControl__e>();
            dfEvents.add(new DrainFlowControl__e(DeviceSerialNumber__c = newAsset.DeviceSerialNumber__c, SwitchOn__c = true));
            EventBus.publish(dfEvents);  
        }
    }
    
    List<Case> caseList = new List<Case>();
    for(Case c : [SELECT Id, Type, Status FROM Case WHERE Type = 'DO' AND Status != 'Closed' AND AssetId IN :assetList]){
        c.Status = 'Closed';
        caseList.add(c);
        system.debug('Adding Case to list' + c);
    }    
    upsert caseList;

}