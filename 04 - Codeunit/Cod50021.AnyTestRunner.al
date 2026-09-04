codeunit 50021 AnyTestRunner
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
    var
        EnabledTestCodeunit: Record "CAL Test Enabled Codeunit";
        Object: Record AllObj;
        CALTestMng: Codeunit "CAL Test Management";
    // Object : Record Object;
    begin
        CALTestMng.EnableTestToRun();
        if EnabledTestCodeunit.FINDSET then
            repeat
                if Object.Get(ObjectType::Codeunit, EnabledTestCodeunit."Test Codeunit ID") then
                    // Message('%1', EnabledTestCodeunit."Test Codeunit ID");
                    CODEUNIT.RUN(EnabledTestCodeunit."Test Codeunit ID");
            until EnabledTestCodeunit.NEXT = 0
        else begin
            Message('No');
        end;
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