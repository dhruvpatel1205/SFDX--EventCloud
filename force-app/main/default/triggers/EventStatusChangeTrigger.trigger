trigger EventStatusChangeTrigger on CAMPX__Event__C (before insert, before update) {
    
    for(CAMPX__Event__C event : Trigger.new) {
        if(Trigger.isInsert) {
            event.CAMPX__StatusChangeDate__c = System.now();
        }

        else if(Trigger.isUpdate) {
            CAMPX__Event__C oldEvent = Trigger.oldMap.get(event.Id);
            if(event.CAMPX__Status__c != oldEvent.CAMPX__Status__c) {
                event.CAMPX__StatusChangeDate__c = System.now();
            }
        }
    }

}