trigger SponsorEventAssociationTrigger on CAMPX__Sponsor__c (before insert, before update) {
    for(CAMPX__Sponsor__c sponsor : Trigger.new){
        
        if(sponsor.CAMPX__Status__c == 'Accepted' && String.isBlank(sponsor.CAMPX__Event__c)){  
            sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
        }
    }
}