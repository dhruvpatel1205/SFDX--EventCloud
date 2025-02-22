@isTest
public with sharing class SponsorEventAssociationTriggerTest {
    @isTest
    static void sponsorEventAssociationTriggerInsertTest() {
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(Name = 'Test Sponsor',CAMPX__Email__c ='test@example.com',CAMPX__Status__c = 'Accepted');
        Test.startTest();
        try{
            insert sponsor;
            System.assert(false,'Insert should have failed');
        } catch(DmlException e) {
            System.assert(e.getMessage().contains('A Sponsor must be associated with an event before being Accepted.'),'Expected error not found');
        }
        Test.stopTest();
    }
    @isTest
    static void sponsorEventAssociationTriggerUpdateTest() {
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(Name = 'Test Sponsor',CAMPX__Email__c ='test@example.com',CAMPX__Status__c='Pending');
        insert sponsor;
        Test.startTest();
        try {
            sponsor.CAMPX__Status__c = 'Accepted';
            update sponsor;
            System.assert(false,'Update should have failed');
        } catch(DmlException e) {
            System.assert(e.getMessage().contains('A Sponsor must be associated with an event before being Accepted.'));
        }

        CAMPX__Event__c event = new CAMPX__Event__c(Name = 'Test Event', CAMPX__Status__c ='Planning');
        
        insert event;
        sponsor.CAMPX__Event__c = event.Id;
        sponsor.CAMPX__Status__c = 'Accepted';
        
        update sponsor;
        Test.stopTest();

        CAMPX__Sponsor__c updatedSponsor = [SELECT CAMPX__Status__c, CAMPX__Event__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor.Id];
        System.assertEquals('Accepted', updatedSponsor.CAMPX__Status__c,'Sponsor Status should be updated to accepted');
    }
}