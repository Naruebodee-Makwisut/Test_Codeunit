table 50001 LogTestRunner
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; UnitID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; UnitName; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; MethodName; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Before; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; After; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Enum StatusEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Message; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(9; Duration; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(10; CallStack; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; UnitID, MethodName, EntryNo)
        {
            Clustered = true;
        }
        key(Key2; EntryNo, Before, After)
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}