codeunit 50116 TestRecallNotificationHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit NormalFunction;

    [Test]
    [HandlerFunctions('RecallNotificationHandler')]
    procedure TestRecallNotification()
    var
        Customer: Record Customer;
    begin
        Customer.Balance := 1000;
        Customer."Credit Amount" := 2000;

        CheckCustomerBalance(Customer);
    end;

    [RecallNotificationHandler]
    procedure RecallNotificationHandler(var TheNotification: Notification): Boolean
    begin
        Assert.AreEqual('Customer balance exceeds credit limit.', TheNotification.Message, 'Notification message is incorrect.');

        exit(true);
    end;

    procedure CheckCustomerBalance(Customer: Record Customer)
    var
        CustomerNotification: Notification;
    begin
        CustomerNotification.ID := CreateGuid();

        CustomerNotification.Message :=
            'Customer balance exceeds credit limit.';

        CustomerNotification.Send();

        if Customer.Balance <= Customer."Credit Amount" then
            CustomerNotification.Recall();
    end;

}