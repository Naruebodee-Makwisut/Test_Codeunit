codeunit 50012 "SalesOrderTests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    // Test หลัก
    [Test]
    procedure Test_PostSalesOrder()
    var
        SalesOrderPage: TestPage "Sales Order";
    begin
        // เปิดหน้า Sales Order
        SalesOrderPage.OpenNew();

        // กรอกข้อมูลผ่าน PageHandler (จะถูกเรียกอัตโนมัติ)
        SalesOrderPage.OK.Invoke();

        // เรียกการ Post (ConfirmHandler จะตอบ Yes)
        // SalesOrderPage.Post.Invoke();

        // หลังจาก Post เสร็จ MessageHandler จะตรวจสอบข้อความ
    end;

    // Handler จำลองการตอบ Yes
    [ConfirmHandler]
    procedure ConfirmPostHandler(Message: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    // Handler ตรวจสอบข้อความผลลัพธ์
    [MessageHandler]
    procedure MessageHandler(Message: Text[1024])
    begin
        Assert.AreEqual('Order posted successfully.', Message, 'Message validation failed.');
    end;

    // Handler เลือก shipment method
    [StrMenuHandler]
    procedure ShipmentMethodHandler(Options: Text; var Choice: Integer; Instruction: Text)
    begin
        Choice := 1;
    end;

    // Handler กรอกข้อมูลในหน้า Sales Order
    [PageHandler]
    procedure SalesOrderPageHandler(var SalesOrderPage: TestPage "Sales Order")
    begin
        SalesOrderPage."No.".SetValue('10000');
    end;

    [HyperlinkHandler]
    procedure TestHyperlink(Message: Text[1024])
    begin

    end;

    [Test]
    [HandlerFunctions('CustomerLookupHandler')]
    procedure TestCustomerLookup()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Init();
        SalesHeader."No." := 'SO001';
        SalesHeader.Insert();

        SalesHeader.Validate("Sell-to Customer No.", '');
        PAGE.RunModal(PAGE::"Customer Lookup");
    end;

    [ModalPageHandler]
    procedure CustomerLookupHandler(var CustomerLookup: TestPage "Customer Lookup")
    begin
        CustomerLookup.First();
        CustomerLookup.OK.Invoke();
    end;

}
