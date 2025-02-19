@isTest
public with sharing class SponsorTierTriggerTest {
    @isTest
    static void sponsorTierTriggerTest() {
        CAMPX__Sponsor__c sponsor1 = new CAMPX__Sponsor__c(CAMPX__ContributionAmount__c = 0, CAMPX__Email__c = 'test1@example.com');
        insert sponsor1;
        sponsor1 = [SELECT CAMPX__Tier__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor1.Id];
        System.assertEquals(null, sponsor1.CAMPX__Tier__c, 'Tier should be null for zero or null contribution');

        // Test case for Bronze tier
        CAMPX__Sponsor__c sponsor2 = new CAMPX__Sponsor__c(CAMPX__ContributionAmount__c = 500, CAMPX__Email__c = 'test2@example.com');
        insert sponsor2;
        sponsor2 = [SELECT CAMPX__Tier__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor2.Id];
        System.assertEquals('Bronze', sponsor2.CAMPX__Tier__c, 'Tier should be Bronze for contribution less than 1000');

        // Test case for Silver tier
        CAMPX__Sponsor__c sponsor3 = new CAMPX__Sponsor__c(CAMPX__ContributionAmount__c = 2000, CAMPX__Email__c = 'test3@example.com');
        insert sponsor3;
        sponsor3 = [SELECT CAMPX__Tier__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor3.Id];
        System.assertEquals('Silver', sponsor3.CAMPX__Tier__c, 'Tier should be Silver for contribution between 1000 and 4999');

        // Test case for Gold tier
        CAMPX__Sponsor__c sponsor4 = new CAMPX__Sponsor__c(CAMPX__ContributionAmount__c = 6000, CAMPX__Email__c = 'test4@example.com');
        insert sponsor4;
        sponsor4 = [SELECT CAMPX__Tier__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor4.Id];
        System.assertEquals('Gold', sponsor4.CAMPX__Tier__c, 'Tier should be Gold for contribution 5000 or more');

        // Test update scenario: from Bronze to Silver
        sponsor2.CAMPX__ContributionAmount__c = 1500;
        update sponsor2;
        sponsor2 = [SELECT CAMPX__Tier__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor2.Id];
        System.assertEquals('Silver', sponsor2.CAMPX__Tier__c, 'Tier should update to Silver after contribution increase');

        // Test update scenario: from Silver to null
        sponsor3.CAMPX__ContributionAmount__c = null;
        update sponsor3;
        sponsor3 = [SELECT CAMPX__Tier__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor3.Id];
        System.assertEquals(null, sponsor3.CAMPX__Tier__c, 'Tier should be null when contribution amount becomes null');
    }
}