@isTest
private class EventNetRevenueTriggerTest {
    @isTest
    static void testInsertWithValidValues() {
        CAMPX__Event__c event = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 1000.00, CAMPX__TotalExpenses__c = 400.00);
        Test.startTest();
        insert event;
        Test.stopTest();
        CAMPX__Event__c insertedEvent = [SELECT Id, CAMPX__NetRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(600.00, insertedEvent.CAMPX__NetRevenue__c, 'Net Revenue should be 600.00');
    }
    @isTest
    static void testInsertWithNullGrossRevenue() {
        CAMPX__Event__c event = new CAMPX__Event__c(CAMPX__GrossRevenue__c = null, CAMPX__TotalExpenses__c = 400.00);
        Test.startTest();
        insert event;
        Test.stopTest();
        CAMPX__Event__c insertedEvent = [SELECT Id, CAMPX__NetRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(null, insertedEvent.CAMPX__NetRevenue__c, 'Net Revenue should be null');
    }
    @isTest
    static void testInsertWithNullTotalExpenses() {
        CAMPX__Event__c event = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 1000.00, CAMPX__TotalExpenses__c = null);
        Test.startTest();
        insert event;
        Test.stopTest();
        CAMPX__Event__c insertedEvent = [SELECT Id, CAMPX__NetRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(null, insertedEvent.CAMPX__NetRevenue__c, 'Net Revenue should be null');
    }
    @isTest
    static void testUpdateWithValidValues() {
        CAMPX__Event__c event = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 1000.00, CAMPX__TotalExpenses__c = 400.00);
        insert event;
        event.CAMPX__GrossRevenue__c = 2000.00;
        event.CAMPX__TotalExpenses__c = 800.00;
        Test.startTest();
        update event;
        Test.stopTest();
        CAMPX__Event__c updatedEvent = [SELECT Id, CAMPX__NetRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(1200.00, updatedEvent.CAMPX__NetRevenue__c, 'Net Revenue should be 1200.00');
    }
    @isTest
    static void testUpdateToNullValues() {
        CAMPX__Event__c event = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 1000.00, CAMPX__TotalExpenses__c = 400.00);
        insert event;
        event.CAMPX__GrossRevenue__c = null;
        Test.startTest();
        update event;
        Test.stopTest();
        CAMPX__Event__c updatedEvent = [SELECT Id, CAMPX__NetRevenue__c FROM CAMPX__Event__c WHERE Id = :event.Id];
        System.assertEquals(null, updatedEvent.CAMPX__NetRevenue__c, 'Net Revenue should be null');
    }
}