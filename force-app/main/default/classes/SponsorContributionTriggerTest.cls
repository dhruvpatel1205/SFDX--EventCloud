@isTest
private class SponsorContributionTriggerTest {
    private static CAMPX__Event__c createEvent() {
        CAMPX__Event__c event = new CAMPX__Event__c(Name='Test Event');
        insert event;
        return event;
    }
    @isTest
    static void testInsertAcceptedSponsors() {
        CAMPX__Event__c event = createEvent();
        
        List<CAMPX__Sponsor__c> sponsors = new List<CAMPX__Sponsor__c>{
            new CAMPX__Sponsor__c(CAMPX__Event__c = event.Id, CAMPX__Status__c = 'Accepted', CAMPX__ContributionAmount__c = 1000, CAMPX__Email__c='test@example.com'),
            new CAMPX__Sponsor__c(CAMPX__Event__c = event.Id, CAMPX__Status__c = 'Accepted', CAMPX__ContributionAmount__c = 500, CAMPX__Email__c='test@example.com')
        };
        
        Test.startTest();
        insert sponsors;
        Test.stopTest();
        
        CAMPX__Event__c updatedEvent = [SELECT CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(1500, updatedEvent.CAMPX__GrossRevenue__c, 
                           'Gross Revenue should be sum of Accepted sponsor contributions');
    }
    @isTest
    static void testInsertNonAcceptedSponsor() {
        CAMPX__Event__c event = createEvent();
        
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(
            CAMPX__Event__c = event.Id,
            CAMPX__Status__c = 'Pending',
            CAMPX__ContributionAmount__c = 1000,
            CAMPX__Email__c ='test@example.com'
        );
        
        Test.startTest();
        insert sponsor;
        Test.stopTest();
        
        CAMPX__Event__c updatedEvent = [SELECT CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(null, updatedEvent.CAMPX__GrossRevenue__c, 
                           'Gross Revenue should be 0 when no Accepted sponsors');
    }
    @isTest
    static void testUpdateToAccepted() {
        CAMPX__Event__c event = createEvent();
        
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(
            CAMPX__Event__c = event.Id,
            CAMPX__Status__c = 'Pending',
            CAMPX__ContributionAmount__c = 1000,
            CAMPX__Email__c ='test@example.com'
        );
        insert sponsor;
        
        sponsor.CAMPX__Status__c = 'Accepted';
        
        Test.startTest();
        update sponsor;
        Test.stopTest();
        
        CAMPX__Event__c updatedEvent = [SELECT CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(1000, updatedEvent.CAMPX__GrossRevenue__c, 
                           'Gross Revenue should reflect updated Accepted sponsor');
    }
    @isTest
    static void testUpdateFromAccepted() {
        CAMPX__Event__c event = createEvent();
        
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(
            CAMPX__Event__c = event.Id,
            CAMPX__Status__c = 'Accepted',
            CAMPX__ContributionAmount__c = 1000,
            CAMPX__Email__c ='test@example.com'
        );
        insert sponsor;
        
        sponsor.CAMPX__Status__c = 'Pending';
        
        Test.startTest();
        update sponsor;
        Test.stopTest();
        
        CAMPX__Event__c updatedEvent = [SELECT CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(0, updatedEvent.CAMPX__GrossRevenue__c, 
                           'Gross Revenue should be 0 after removing Accepted status');
    }
    @isTest
    static void testDeleteAcceptedSponsor() {
        CAMPX__Event__c event = createEvent();
        
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(
            CAMPX__Event__c = event.Id,
            CAMPX__Status__c = 'Accepted',
            CAMPX__ContributionAmount__c = 1000,
            CAMPX__Email__c ='test@example.com'
        );
        insert sponsor;
        
        Test.startTest();
        delete sponsor;
        Test.stopTest();
        
        CAMPX__Event__c updatedEvent = [SELECT CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(0, updatedEvent.CAMPX__GrossRevenue__c, 
                           'Gross Revenue should be 0 after deleting Accepted sponsor');
    }
    @isTest
    static void testUndeleteAcceptedSponsor() {
        CAMPX__Event__c event = createEvent();
        
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(
            CAMPX__Event__c = event.Id,
            CAMPX__Status__c = 'Accepted',
            CAMPX__ContributionAmount__c = 1000,
            CAMPX__Email__c ='test@example.com'
        );
        insert sponsor;
        delete sponsor;
        
        Test.startTest();
        undelete sponsor;
        Test.stopTest();
        
        CAMPX__Event__c updatedEvent = [SELECT CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(1000, updatedEvent.CAMPX__GrossRevenue__c, 
                           'Gross Revenue should reflect undeleted Accepted sponsor');
    }
}