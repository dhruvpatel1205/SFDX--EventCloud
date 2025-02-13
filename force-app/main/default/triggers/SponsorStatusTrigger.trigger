trigger SponsorStatusTrigger on CAMPX__Sponsor__c (before insert) {
    for(CAMPX__Sponsor__c sponsor : Trigger.new) {
        if(sponsor.CAMPX__Status__c == null || sponsor.CAMPX__Status__c.trim()==''){
            sponsor.CAMPX__Status__c= 'Pending';
        }
    }
}