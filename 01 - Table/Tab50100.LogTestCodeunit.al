table 50100 "LogTestCodeunit"
{
    DataClassification = ToBeClassified;
    Caption = 'Log Test Codeunit';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeries.TestManual(SalesSetup."Test Codeunit");
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Method"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();

            SalesSetup.TestField("Test Codeunit");

            "No." := NoSeries.GetNextNo(SalesSetup."Test Codeunit", WorkDate(), true);
        end;
    end;
}