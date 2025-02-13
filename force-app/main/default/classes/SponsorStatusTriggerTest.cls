@isTest
public with sharing class SponsorStatusTriggerTest {
    @isTest
    static void sponsorStatusTriggerDefault() {
        Test.startTest();
        CAMPX__Sponsor__c sponsorRecord = new CAMPX__Sponsor__c(Name ='Test Sponsor');  
        insert sponsorRecord;
        sponsorRecord = [SELECT Id, CAMPX__Status__c FROM CAMPX__Sponsor__c WHERE Id = : sponsorRecord.Id];
        Test.stopTest();
        System.assertEquals('Pending', sponsorRecord.CAMPX__Status__c, 'CAMPX__Status__c should be set to "Pending"');
    }
    @isTest
    static void sponsorStatusTriggerNotOverWritten() {
        Test.startTest();
        CAMPX__Sponsor__c sponsorRecord = new CAMPX__Sponsor__c(Name ='Active Sponsor', CAMPX__Status__c = 'Accepted');  
        insert sponsorRecord;
        sponsorRecord = [SELECT Id, CAMPX__Status__c FROM CAMPX__Sponsor__c WHERE Id = : sponsorRecord.Id];
        Test.stopTest();
        System.assertEquals('Accepted', sponsorRecord.CAMPX__Status__c, 'CAMPX__Status__c should not be changed to any other value');
    }
}