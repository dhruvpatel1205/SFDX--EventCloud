@isTest
public with sharing class EventStatusTriggerTest {
    @isTest
    static void EventStatusTest() {
        Test.startTest();
        CAMPX__Event__C newEvent = new CAMPX__Event__C();
        insert newEvent;
        CAMPX__Event__C insertEvent = [SELECT CAMPX__Status__c FROM CAMPX__Event__C WHERE Id = : newEvent.Id LIMIT 1];
        Test.stopTest();
        System.assertEquals('Planning', insertEvent.CAMPX__Status__c,'Status Should be set to planning');
    }
}