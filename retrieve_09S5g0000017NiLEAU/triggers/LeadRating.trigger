/*Whenever Lead is created with Lead Source as Web, Rating should be cold otherwise Hot 
Object - Lead
Event - Before
DML - Insert
*/
trigger LeadRating on Lead (before insert) {
    for(Lead l : Trigger.new){
        If(l.LeadSource == 'Web'){
            l.Rating = 'Cold';
        }
        
        else
            l.Rating = 'Hot';
    }    

}