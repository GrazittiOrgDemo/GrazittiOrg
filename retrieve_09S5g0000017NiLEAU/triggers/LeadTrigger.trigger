/*Prefix First Name with Dr when Lead is Created Or Updated
Which Object : Lead
Which Event : Before
Which DML : Insert and Update

*/

trigger LeadTrigger on Lead (before insert, before update) {
    for(Lead l : Trigger.new){
        System.debug('Trigger New Lead'+Trigger.New);
        l.FirstName = 'Dr. ' + l.FirstName;
        System.debug('Trigger New Lead'+Trigger.New);
    }

}