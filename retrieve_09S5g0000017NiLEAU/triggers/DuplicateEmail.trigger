/* When Lead is created or Updated then check if the email of the lead is already there in the 
existing Contacts
If email already exists, then throw an error

Object - Lead
Event - before
DML - insert, update

Logic-
Fetch lead using Trigger.New
Fetch Contact using list

*/


trigger DuplicateEmail on Lead (before Insert, before update) {
    
   Map<String,Contact> conMap = new Map<String,Contact>();
   List<Contact>conList = new List<Contact>();
   
   conList = [Select id,email from Contact];
   
   if(conList.size()>0 && !conList.isEmpty()){
       for(Contact c: conList){
           conMap.put(c.Email, c);
       }
    }
    
    for(Lead ld : Trigger.new){
      
           if((ld.email!=null) && (trigger.isInsert || (ld.email!=trigger.oldmap.get(ld.Id).email))){
               if(conMap.containskey(ld.email)){
                   ld.addError('Email already exists');
               }
           }
       
    }
    
    
   
}