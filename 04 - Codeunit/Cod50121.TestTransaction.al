codeunit 50121 TestTransaction
{
    Subtype = Test;
    RequiredTestIsolation = Function;

    [Test]
    [TransactionModel(TransactionModel::AutoCommit)]
    procedure CreateLog()
    var
        CustomerTB: Record "Customer";
    begin
        CustomerTB.Init();
        CustomerTB.Validate("No.", 'TNO03');
        CustomerTB.Validate(Name, 'TT03');
        CustomerTB.Insert();
    end;

    [Test]
    [HandlerFunctions('GetLogMessage')]
    procedure GetLog()
    var
        CustomerTB: Record "Customer";
    begin
        if CustomerTB.Get('TNO03') then
            Message('Complete %1', CustomerTB."No.")
    end;

    [MessageHandler]
    procedure GetLogMessage(MessageText: Text)
    begin
        if MessageText <> 'Complete TNO03' then
            Error('Unexpected message: %1', MessageText);
    end;
}