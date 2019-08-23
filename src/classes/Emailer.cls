public class Emailer implements Schedulable{
    public void execute(SchedulableContext sc){
        SendEmail();
    }
    
    public static void SendEmail(){
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.setToAddresses(new String[] {'thinathayalan@mstsolutions.com', 'dheenu27@hotmail.com'});
        msg.setSubject('test');
        msg.setPlainTextBody('hello world-1!');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{msg});        
        
    }

}