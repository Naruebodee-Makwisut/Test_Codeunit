codeunit 50023 TestIsolationDisabled
{
    Subtype = Test;
    RequiredTestIsolation = Disabled;

    [Test]
    [TransactionModel(TransactionModel::AutoCommit)]
    [HandlerFunctions('CustomerMessageHandler')]
    procedure InsertCustomer()
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := 'TEST999';
        Customer.Name := 'Test Customer1';
        Customer.Insert();

        COMMIT;

        Message('Customer exists after COMMIT');
    end;

    [MessageHandler]
    procedure CustomerMessageHandler(MessageText: Text)
    begin
        // สามารถทำการตรวจสอบ (Assert) ได้ว่าข้อความตรงกับที่คิดไว้หรือไม่
        if MessageText <> 'Customer exists after COMMIT' then
            Error('Unexpected message: %1', MessageText);
    end;

}