codeunit 50010 MyCodeunit10
{
    Subtype = Test;
    RequiredTestIsolation = Function;

    var
        Assert: Codeunit "Library Assert";

    procedure CreateTestCustomer(CustomerNo: Code[20]; CustomerName: Text[100])
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := CustomerNo;
        Customer.Name := CustomerName;
        Customer.Insert();
    end;

    [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    [HandlerFunctions('OpenPageHandler')]
    procedure TestCustomerPage()
    var
        Customer: Record Customer;
    begin
        CreateTestCustomer('50014', 'Customer12');

        Customer.Get('50004');
        PAGE.Run(PAGE::"Customer Card", Customer);

    end;

    [PageHandler]
    procedure OpenPageHandler(var Customer: TestPage "Customer Card")
    begin
        Assert.AreEqual('50004', Customer."No.".Value, 'Customer No. is incorrect.');
        Assert.AreEqual('Customer2', Customer.Name.Value, 'Customer Name is incorrect.');

        Customer.Name.SetValue('Updated Name');
        // Customer.OK.Invoke();

        Assert.AreEqual('Updated Name', Customer.Name.Value, 'Customer Name was not updated.');
        Customer.OK.Invoke();
    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure TestWithoutMessage()
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := 'TEST001';
        Customer.Name := 'Test Customer';
        Customer.Insert();

    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024])
    begin
        Assert.IsTrue(StrPos(Message, 'Document has been created') > 0, Message);
    end;

}
