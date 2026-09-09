codeunit 50114 TestSendNotificationHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit NormalFunction;

    [Test]
    [HandlerFunctions('SendNotificationHandler')]
    procedure TestCustomerNotification()
    begin
        HandleFunction.CheckCustomer();
    end;

    [SendNotificationHandler]
    procedure SendNotificationHandler(var Notification: Notification): Boolean
    begin
        Assert.AreEqual('Customer has been created.', Notification.Message, 'Notification message is incorrect.');
    end;

}