codeunit 50006 "Test_TransactionH"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TransactionCode_ShouldBeBlockedCustomer()
    var
        TransHeader: Record "LSC Transaction Header";
        Customer: Record Customer;
        Store: Record "LSC Store";
    begin
        // Arrange
        CreateStore(Store, 'S001', 5);

        CreateCustomer(Customer, 'C001');
        Customer.Blocked := Customer.Blocked::Invoice;
        Customer.Modify();

        CreateTransactionHeader(TransHeader, Store."No.", Customer."No.");

        // Act
        TransHeader.Validate("Transaction Code");

        // Assert
        Assert.AreEqual(TransHeader."Transaction Code"::"Blocked Customer", TransHeader."Transaction Code", 'Transaction Code should be Blocked Customer.');
    end;

    [Test]
    procedure TransactionCode_ShouldBeSalePaymentDifference()
    var
        TransHeader: Record "LSC Transaction Header";
        Customer: Record Customer;
        Store: Record "LSC Store";
    begin
        // Arrange
        CreateStore(Store, 'S001', 5);
        CreateCustomer(Customer, 'C002');

        CreateTransactionHeader(TransHeader, Store."No.", Customer."No.");

        TransHeader."Gross Amount" := 100;
        TransHeader.Payment := -90;
        TransHeader."Income/Exp. Amount" := 0;
        // Diff = 10 > Allowed 5

        // Act
        TransHeader.Validate("Transaction Code");

        // Assert
        Assert.AreEqual(TransHeader."Transaction Code"::"Sale/Pmt. Difference", TransHeader."Transaction Code", '');
    end;

    [Test]
    procedure TransactionCode_ShouldBeBlank_WhenDifferenceWithinLimit()
    var
        TransHeader: Record "LSC Transaction Header";
        Customer: Record Customer;
        Store: Record "LSC Store";
    begin
        // Arrange
        CreateStore(Store, 'S001', 20);
        CreateCustomer(Customer, 'C003');

        CreateTransactionHeader(TransHeader, Store."No.", Customer."No.");

        TransHeader."Gross Amount" := 100;
        TransHeader.Payment := -90;
        TransHeader."Income/Exp. Amount" := 0;
        // Diff = 10 <= Allowed 20

        // Act
        TransHeader.Validate("Transaction Code");

        // Assert
        Assert.AreEqual(TransHeader."Transaction Code"::" ", TransHeader."Transaction Code", '');
    end;

    [Test]
    procedure TransactionCode_ShouldBeSalePaymentDifference_WhenCustomerNotFound()
    var
        TransHeader: Record "LSC Transaction Header";
        Store: Record "LSC Store";
    begin
        // Arrange
        CreateStore(Store, 'S001', 5);

        CreateTransactionHeader(TransHeader, Store."No.", 'NOTEXIST');

        TransHeader."Gross Amount" := 100;
        TransHeader.Payment := -90;
        TransHeader."Income/Exp. Amount" := 0;

        // Act
        TransHeader.Validate("Transaction Code");

        // Assert
        Assert.AreEqual(TransHeader."Transaction Code"::"Sale/Pmt. Difference", TransHeader."Transaction Code", '');
    end;

    [Normal]
    local procedure CreateStore(var Store: Record "LSC Store"; StoreNo: Code[20]; AllowedDiff: Decimal)
    begin
        if Store.Get(StoreNo) then
            exit;

        Store.Init();
        Store."No." := StoreNo;
        Store.Name := 'Test Store';
        Store."Allowed Diff. in Trans." := AllowedDiff;
        Store.Insert();
    end;

    local procedure CreateCustomer(var Customer: Record Customer; CustomerNo: Code[20])
    begin
        if Customer.Get(CustomerNo) then
            exit;

        Customer.Init();
        Customer."No." := CustomerNo;
        Customer.Name := 'Test Customer';
        Customer.Insert();
    end;

    local procedure CreateTransactionHeader(
        var TransHeader: Record "LSC Transaction Header";
        StoreNo: Code[20];
        CustomerNo: Code[20])
    begin
        TransHeader.Init();

        // ใส่ Primary Key และ Mandatory Fields ของตารางจริง
        // เช่น
        // TransHeader."Entry No." := 1;

        TransHeader."Store No." := StoreNo;
        TransHeader."Customer No." := CustomerNo;

        TransHeader.Insert(true);
    end;
}