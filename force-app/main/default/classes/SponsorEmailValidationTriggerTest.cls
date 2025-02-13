@isTest
public with sharing class SponsorEmailValidationTriggerTest {
    @isTest
    static void sponsorWithEmailTest() {
        Test.startTest();
        CAMPX__Sponsor__c sponsorRecord = new CAMPX__Sponsor__c(Name ='Test Sponsor');
        try{
            insert sponsorRecord;
            System.assert(false, 'Error Expected when inserting sponsor without an email');
        } catch(DmlException exc) {
            System.assert(exc.getMessage().contains('A sponsor can not be created without an email address'), 'Error message should be "Email is required for Sponsor"');
        }
        Test.stopTest();
    }
    @isTest
    static void sponsorWithoutEmailTest() {
        Test.startTest();
        CAMPX__Sponsor__c sponsorRecord = new CAMPX__Sponsor__c(Name ='Test Sponsor', CAMPX__Email__c='test@example.com');
        insert sponsorRecord;
        sponsorRecord = [SELECT Id, CAMPX__Email__c FROM CAMPX__Sponsor__c WHERE Id =: sponsorRecord.Id];
        Test.stopTest();
        System.assertNotEquals(null, sponsorRecord.Id, 'Sponsor should be inserted');
    }
}