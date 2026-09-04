table 50003 TestInsert
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[250])
        {

        }
        field(3; Date; Date)
        {

        }
        field(4; Time; Time)
        {

        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

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