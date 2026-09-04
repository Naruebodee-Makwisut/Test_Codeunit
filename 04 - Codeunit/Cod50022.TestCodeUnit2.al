codeunit 50022 TestCodeUnit2
{
    Subtype = Test;
    RequiredTestIsolation = Disabled;

    var
        Assert: Codeunit "Library Assert";

    // 🔹 Helper Method สำหรับสร้าง Customer
    procedure CreateCustomer(CustomerNo: Code[20]; CustomerName: Text[100])
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := CustomerNo;
        Customer.Name := CustomerName;
        Customer.Insert();
    end;

    // 🔹 Test Method: ตรวจสอบการสร้าง Customer
    [Test]
    procedure TestCustomerCreation()
    var
        Customer: Record Customer;
    begin
        CreateCustomer('CUST001', 'Test Customer');

        Customer.Get('CUST001');
        Assert.AreEqual('Test Customer', Customer.Name, 'Customer Name is incorrect.');
    end;

    // 🔹 Test Method + PageHandler: เปิดหน้า Customer Card
    [Test]
    [HandlerFunctions('CustomerCardHandler')]
    procedure TestCustomerCardPage()
    var
        Customer: Record Customer;
    begin
        CreateCustomer('CUST002', 'Customer Card Test');
        Customer.Get('CUST002');
        PAGE.Run(PAGE::"Customer Card", Customer);
    end;

    [PageHandler]
    procedure CustomerCardHandler(var CustomerCard: TestPage "Customer Card")
    begin
        Assert.AreEqual('CUST002', CustomerCard."No.".Value, 'Customer No. mismatch.');
        Assert.AreEqual('Customer Card Test', CustomerCard.Name.Value, 'Customer Name mismatch.');

        CustomerCard.Name.SetValue('Updated Name');
        // CustomerCard.OK.Invoke();

        Assert.AreEqual('Updated Name', CustomerCard.Name.Value, 'Customer Name was not updated.');
    end;

    // 🔹 Test Method + MessageHandler: ตรวจสอบข้อความแจ้งเตือน
    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure TestMessageOnInsert()
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := 'CUST003';
        Customer.Name := 'Message Test';
        Customer.Insert();

        Message('Document has been created');
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024])
    begin
        Assert.IsTrue(StrPos(Message, 'Document has been created') > 0, 'Expected message not found.');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoCommit)]
    procedure TestCreateWithTestPage()
    var
        TestInsert: TestPage TestInsertPage;
    begin
        TestInsert.OpenNew();

        // TestInsert.ID.SetValue('Test01');
        TestInsert.Name.SetValue('Insert01');

        // Assert.AreEqual('Test01', TestInsert.ID.Value, 'Customer No. mismatch.');    
        Assert.AreEqual('Insert01', TestInsert.Name.Value, 'Customer Name mismatch.');

        TestInsert.OK.Invoke();
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoCommit)]
    procedure TestEditCustomerWithTestPage()
    var
        TestInsertCard: TestPage TestInsertCard;
        TestInsert: Record TestInsert;
    begin
        TestInsert.Init();
        TestInsert.ID := 10000;
        TestInsert.Name := 'Customer Before Edit';
        TestInsert.Insert();
        TestInsert.Get(TestInsert.ID);

        TestInsertCard.Filter.SetFilter(ID, '10000');
        TestInsertCard.OpenEdit();

        TestInsertCard.Name.SetValue('Customer After Edit');
        TestInsertCard.OK.Invoke();

        TestInsert.Get(10000);
        Assert.AreEqual('Customer After Edit', TestInsert.Name, 'Customer Name was not updated.');
    end;

    [Test]
    [HandlerFunctions('MessageInsert')]
    [TransactionModel(TransactionModel::AutoCommit)]
    procedure TestInsertAndCommit()
    var
        TestInsert: Record TestInsert;
    begin
        TestInsert.Init();
        TestInsert.ID := 10000;
        TestInsert.Name := 'Customer Before Edit';
        TestInsert.Insert();

        Message('Insert Complete!');
    end;

    [MessageHandler]
    procedure MessageInsert(Message: Text[1024])
    begin
        Assert.IsTrue(StrPos(Message, 'Insert Complete!') > 0, 'Expected message not found.');
    end;
}