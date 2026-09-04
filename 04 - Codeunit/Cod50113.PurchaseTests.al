codeunit 50113 "PurchaseTests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    [HandlerFunctions('ConfirmHandlerYes,MessageHandlerInfo,StrMenuHandlerSelect')]
    procedure Test_PostPurchaseOrder()
    var
        PurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        // Arrange: สร้าง Purchase Order
        PurchaseHeader.Init();
        PurchaseHeader."No." := 'PO001';
        PurchaseHeader.Insert();

        // Act: เรียกฟังก์ชัน Post (จะมี Confirm และ StrMenu โผล่มา)
        CODEUNIT.Run(CODEUNIT::"Purch.-Post", PurchaseHeader);

        // Assert: ตรวจสอบว่ามีการ Post สำเร็จ
        // Assert.AreEqual(PurchaseHeader.Status, PurchaseHeader.Status::Released, 'Purchase Order should be released.');

        // Assert: ตรวจสอบว่ามี Invoice ถูกสร้าง
        if PurchInvHeader.Get(PurchaseHeader."No.") then
            Assert.IsTrue(true, 'Purchase Order was posted as Invoice.')
        else
            Assert.Fail('Purchase Order was not posted.');

    end;

    // Handler จำลองการตอบ Yes ใน Confirm
    [ConfirmHandler]
    procedure ConfirmHandlerYes(Message: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    // Handler ตรวจสอบข้อความที่ระบบแสดง
    [MessageHandler]
    procedure MessageHandlerInfo(Message: Text[1024])
    begin
        Assert.AreEqual('Purchase order posted successfully.', Message, '');
    end;

    // Handler จำลองการเลือกเมนู (เช่น เลือกวิธีการรับสินค้า)
    [StrMenuHandler]
    procedure StrMenuHandlerSelect(Options: Text[1024]; var Choice: Integer; Instruction: Text[1024])
    begin
        Choice := 2; // เลือก Option ที่สอง
    end;
}
