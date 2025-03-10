trigger SponsorContirbutionTrigger on CAMPX__Sponsor__c (after insert, after update, after delete, after undelete) {
    Set<Id> eventIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for(CAMPX__Sponsor__c sponsor: Trigger.new) {
            if(sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Event__c != null) {
                eventIds.add(sponsor.CAMPX__Event__c);
            }
        }
    }
    if(Trigger.isUpdate || Trigger.isDelete) {
        for(CAMPX__Sponsor__c sponsor: Trigger.old) {
            if(sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Event__c != null) {
                eventIds.add(sponsor.CAMPX__Event__c);
            }
        }
    }
    if(eventIds.isEmpty()) return;
    Map<Id, Decimal> eventRevenue = new Map<Id, Decimal>();
    for(AggregateResult result : [SELECT CAMPX__Event__c eventId, SUM(CAMPX__ContributionAmount__c) totalRevenue
                                  FROM CAMPX__Sponsor__c
                                  WHERE CAMPX__Event__c IN :eventIds
                                  AND CAMPX__Status__c = 'Accepted'
                                  GROUP BY CAMPX__Event__c]) {
        eventRevenue.put((Id)result.get('eventId'), (Decimal)result.get('totalRevenue'));
    }
    List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
    for(Id eventId : eventIds) {
        CAMPX__Event__c event = new CAMPX__Event__c(Id = eventId, CAMPX__GrossRevenue__c = eventRevenue.containsKey(eventId) ? eventRevenue.get(eventId) : 0);
        eventsToUpdate.add(event);
    }
    if(!eventsToUpdate.isEmpty()) {
        update eventsToUpdate;
    }
}