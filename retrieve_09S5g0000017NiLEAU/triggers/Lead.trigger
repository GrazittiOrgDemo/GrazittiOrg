trigger Lead on Lead (before Update, before insert) {
    for(lead l : Trigger.new){
        l.firstname= 'Dr. '+ l.firstname;
    }

}