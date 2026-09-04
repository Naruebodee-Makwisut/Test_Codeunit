codeunit 50116 TestRecallNotificationHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit HandleFunction;

    [Test]
    [HandlerFunctions('RecallNotificationHandler')]
    procedure TestRecallNotification()
    var
        Customer: Record Customer;
    begin
        Customer.Balance := 1000;
        Customer."Credit Amount" := 2000;

        HandleFunction.CheckCustomerBalance(Customer);
    end;

    [RecallNotificationHandler]
    procedure RecallNotificationHandler(
        var TheNotification: Notification): Boolean
    begin
        Assert.AreEqual('Customer balance exceeds credit limit.', TheNotification.Message, 'Notification message is incorrect.');

        exit(true);
    end;



}