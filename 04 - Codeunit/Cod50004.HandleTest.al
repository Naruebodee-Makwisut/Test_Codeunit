codeunit 50004 HandleTest
{
    Subtype = Test;

    var
        HandleF: Codeunit NormalFunction;
        Assert: Codeunit "Library Assert";

    [Test]
    [HandlerFunctions('MyConfirmHandler')]
    procedure TestDelete()
    begin
        Assert.IsTrue(HandleF.DeleteCustomer(), 'Should return true.');
    end;

    [ConfirmHandler]
    procedure MyConfirmHandler(Question: Text; var Reply: Boolean)
    begin
        Reply := true;
    end;

    [Test]
    [HandlerFunctions('MyMessageHandler')]
    procedure TestMessage()
    begin
        HandleF.ShowMessage();
    end;

    [MessageHandler]
    procedure MyMessageHandler(Message: Text)
    begin
        Assert.AreEqual('Completed.', Message, 'Wrong message.');
    end;

    [Test]
    [HandlerFunctions('MyMenuHandler')]
    procedure TestMenu()
    var
        Result: Integer;
    begin
        Result := HandleF.SelectOption();

        Assert.AreEqual(2, Result, '');
    end;


    [StrMenuHandler]
    procedure MyMenuHandler(Options: Text[1024]; var Choice: Integer; Instruction: Text[1024])
    begin
        Choice := 1;
    end;

    [Test]
    [HandlerFunctions('CustomerPageHandler')]
    procedure TestOpenCustomerPage()
    begin
        OpenCustomer();
    end;


    [PageHandler]
    procedure CustomerPageHandler(var CustomerPage: TestPage "Customer Card")
    begin
        Assert.IsTrue(CustomerPage.Editable(), 'Page should be editable');
    end;

    procedure OpenCustomer()
    var
        Customer: Record Customer;
    begin
        Page.Run(Page::"Customer Card");
    end;

}