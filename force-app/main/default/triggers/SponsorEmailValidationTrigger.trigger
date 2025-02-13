trigger SponsorEmailValidationTrigger on CAMPX__Sponsor__c (before insert) {
    for(CAMPX__Sponsor__c sponsorRecord : Trigger.new) {
        if(sponsorRecord.CAMPX__Email__c == null || sponsorRecord.CAMPX__Email__c.trim()==''){
            sponsorRecord.addError('A sponsor can not be created without an email address');
        }
    }
}