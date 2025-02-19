trigger SponsorTierTrigger on CAMPX__Sponsor__c (before insert, before update) {
    for(CAMPX__Sponsor__c sponsorRecord : Trigger.new) {
        if(sponsorRecord.CAMPX__ContributionAmount__c == null || sponsorRecord.CAMPX__ContributionAmount__c <= 0) {
            sponsorRecord.CAMPX__Tier__c = null;
        }
        else if(sponsorRecord.CAMPX__ContributionAmount__c>0 && sponsorRecord.CAMPX__ContributionAmount__c<1000) {
            sponsorRecord.CAMPX__Tier__c = 'Bronze';
        }
        else if(sponsorRecord.CAMPX__ContributionAmount__c>=1000 && sponsorRecord.CAMPX__ContributionAmount__c<5000) {
            sponsorRecord.CAMPX__Tier__c = 'Silver';
        }
        else {
            sponsorRecord.CAMPX__Tier__c = 'Gold';
        }
    }
}   