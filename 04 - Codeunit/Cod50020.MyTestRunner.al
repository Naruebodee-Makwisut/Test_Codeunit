codeunit 50020 MyTestRunner
{
    Subtype = TestRunner;
    TestIsolation = Codeunit;

    var
        Before: DateTime;

    trigger OnBeforeTestRun(CodeunitId: Integer; CodeunitName: Text; FunctionName: Text; Permissions: TestPermissions): Boolean
    begin
        Before := CURRENTDATETIME;
        Exit(true);
    end;

    trigger OnRun()
    begin
        // Codeunit.Run(Codeunit::TestHyperLinkHandler);
        // Codeunit.Run(Codeunit::TestSendNotificationHandler);
        // Codeunit.Run(Codeunit::TestRecallNotificationHandler);
        // Codeunit.Run(Codeunit::TestFilterPageHandler);
        // Codeunit.Run(Codeunit::TestTransaction);
        // Codeunit.Run(Codeunit::MyReportFullTest);
        Codeunit.Run(Codeunit::TestFilterPageHandler);
    end;

    trigger OnAfterTestRun(CodeunitId: Integer; CodeunitName: Text; FunctionName: Text; Permissions: TestPermissions; Success: Boolean)
    var
        log: Record LogTestRunner;
    begin
        Clear(log);
        log.Init();
        log.UnitID := CodeunitId;
        log.UnitName := CodeunitName;
        log.MethodName := FunctionName;
        log.Before := Before;
        log.After := CurrentDateTime;
        if Success then
            log.Status := log.Status::Success
        else begin
            log.Status := log.Status::Failure;
            if FunctionName <> '' then
                log.Message := GetLastErrorText;
        end;
        log.Duration := log.After - log.Before;
        log.Insert();
    end;
}