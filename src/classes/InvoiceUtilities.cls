global with sharing class InvoiceUtilities {
    
    webservice static String renumberLineItems(String invoiceName){
        // Create a copy of the target Invoice object and its Line Items.
		// Loop through each Line Item, re-numbering as you go
		// Update the Line Items in one transaction, rollback if any problems
		// and return error messages to the calling environment.
		// On success, return a message to the calling program.

        Invoice__c invoice = [Select i.Name, (Select Name From Line_Items__r ORDER BY Name)
                             From Invoice__c i
                             Where i.Name = :invoiceName LIMIT 1];
        
        Integer i = 1;
        for(Line_Item__c item: invoice.Line_Items__r){
            item.Name = String.valueOf(i);
            System.debug(item.Name);
            i++;
        }
        
        try{
            Database.update(invoice.Line_Items__r);
        }catch (DmlException e){            
            return e.getMessage();
        }
        
        return 'Line items renumbered successfully.';
    }


}