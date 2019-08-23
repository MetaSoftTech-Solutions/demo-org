public with sharing class ImportDeals implements Schedulable{
     public void execute(SchedulableContext sc){
        ImportDeals();
    }
    
    public static void ImportDeals(){
        List<Deal_Site__c> sites = [SELECT Feed_Url__c from Deal_Site__c];
        System.debug('Total Sites found: ' + sites.size());
        
        List<Deal__c> deals = new List<Deal__c>();
                
        for(Deal_Site__c dealSite: sites){
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(dealSite.Feed_Url__c);
            req.setMethod('GET');
            HttpResponse res = h.send(req);
            Dom.Document doc = res.getBodyDocument();
            Dom.XMLNode rss = doc.getRootElement();
            System.debug('@@' + rss.getName());
            
            List<Dom.XMLNode> rssList = new List<Dom.XMLNode>();
            for(Dom.XMLNode child : rss.getChildren()) {
               System.debug('@@@' + child.getName());
               for(Dom.XMLNode channel : child.getChildren()) {
                   System.debug('@@@@' + channel.getName());
                   if(channel.getName() == 'item') {
                    Deal__c deal = new Deal__c();               	
                       for(Dom.XMLNode item : channel.getChildren()){
                           if(item.getName() == 'title'){
                               string title = item.getText();
                               if(title.length() > 80)
                                   title = title.substring(0, 79);
                               deal.Name = title;
                           }
                                
                           if(item.getName() == 'description')
                               deal.Description__c = item.getText();
                           if(item.getName() == 'link')
                                deal.Link__c = item.getText();
                       }
                       	deals.add(deal);                                                             
                   }
               }
            }
        }
        
        try{
            System.debug('Inserting ' + deals.size() + ' Records');
            insert deals;
        }catch(DmlException  e){
            
        }
    }
}