trigger EventNetRevenueTrigger on CAMPX__Event__c (before insert, before update) {
    for(CAMPX__Event__c event: Trigger.new) {
        if(event.CAMPX__GrossRevenue__c !=null && event.CAMPX__TotalExpenses__c != null) {
            event.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
        } else {
            event.CAMPX__NetRevenue__c = null;
        }
    }
}