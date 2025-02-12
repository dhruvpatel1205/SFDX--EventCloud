@isTest
public with sharing class EventStatusChangeTriggerTest {
    @isTest
    static void eventStatusChangeDateOnInsertTest() {
        Test.startTest();
        CAMPX__Event__c eventRecord = new CAMPX__Event__c(CAMPX__Status__c = 'Planning');
        insert eventRecord;
        Test.stopTest();
        eventRecord = [SELECT Id,CAMPX__Status__c, CAMPX__StatusChangeDate__c FROM CAMPX__Event__c WHERE Id = :eventRecord.Id];
        System.assertNotEquals(null,eventRecord.CAMPX__StatusChangeDate__c,'Status Change Date should be updated');
    }
    @isTest
    static void eventStatusChangeDateOnUpdate() {
        CAMPX__Event__c eventRecord = new CAMPX__Event__c(CAMPX__Status__c = 'Planning');
        insert eventRecord;
        Test.startTest();
        eventRecord.CAMPX__Status__c = 'Completed';
        update eventRecord;
        Test.stopTest();

        eventRecord = [SELECT Id, CAMPX__StatusChangeDate__c FROM CAMPX__Event__c WHERE Id = :eventRecord.Id];
        System.assertNotEquals(null,eventRecord.CAMPX__StatusChangeDate__c,'Status Change Date should be updated');
    }
}