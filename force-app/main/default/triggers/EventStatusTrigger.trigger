trigger EventStatusTrigger on CAMPX__EVENT__C (before insert) {
    for(CAMPX__EVENT__C event : Trigger.new) {
            event.CAMPX__Status__c= 'Planning';
    }
}