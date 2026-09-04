table 50002 "AL Test Runner Log"
{
    DataClassification = CustomerContent;
    Caption = 'AL Test Runner Log';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Test Suite Name"; Code[10])
        {
            Caption = 'Test Suite Name';
        }
        field(3; "Codeunit ID"; Integer)
        {
            Caption = 'Codeunit ID';
        }
        field(4; "Codeunit Name"; Text[30])
        {
            Caption = 'Codeunit Name';
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Codeunit), "Object ID" = field("Codeunit ID")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(5; "Function Name"; Text[128])
        {
            Caption = 'Function Name';
        }
        field(6; "Run Status"; Option)
        {
            Caption = 'Run Status';
            OptionMembers = " ",Disabled,Success,Failure,Skipped;
            OptionCaption = ' ,Disabled,Success,Failure,Skipped';
        }
        field(7; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
        }
        field(8; "Error Call Stack"; Blob)
        {
            Caption = 'Error Call Stack';
        }
        field(9; "Execution Time (ms)"; DateTime)
        {
            Caption = 'Execution Time (ms)';
        }
        field(10; "Execution Date-Time"; DateTime)
        {
            Caption = 'Execution Date-Time';
        }
        field(11; "Executed By"; Code[50])
        {
            Caption = 'Executed By';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Test Suite Name", "Codeunit ID", "Function Name")
        {
        }
        key(Key2; "Execution Date-Time")
        {
        }
    }

    // Helper Function สำหรับเซฟ Error Call Stack ยาวๆ เข้า BLOB Field
    procedure SetCallStack(CallStackText: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Error Call Stack");
        if CallStackText = '' then
            exit;
        "Error Call Stack".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(CallStackText);
    end;

    // Helper Function สำหรับอ่าน Error Call Stack ออกมาจาก BLOB Field
    procedure GetCallStack(): Text
    var
        InStream: InStream;
        CallStackText: Text;
    begin
        CalcFields("Error Call Stack");
        if not "Error Call Stack".HasValue() then
            exit('');
        "Error Call Stack".CreateInStream(InStream, TEXTENCODING::UTF8);
        InStream.ReadText(CallStackText);
        exit(CallStackText);
    end;
}