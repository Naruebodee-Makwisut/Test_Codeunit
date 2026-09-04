page 50100 "Dup Mobile Phone List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Integer; // ใช้ Virtual Table Integer
    Editable = false;
    Caption = 'Duplicate Mobile Phone List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(MobilePhone; GetCurrentMobilePhone())
                {
                    ApplicationArea = All;
                    Caption = 'Mobile Phone No.';
                    ToolTip = 'Specifies the duplicate mobile phone number.';
                }
                field(DuplicateCount; GetCurrentCount())
                {
                    ApplicationArea = All;
                    Caption = 'Duplicate Count';
                    ToolTip = 'Specifies how many times this phone number appears.';
                }
            }
        }
    }

    var
        PhoneList: List of [Text[30]];
        CountList: List of [Integer];

    trigger OnOpenPage()
    begin
        LoadQueryData();
    end;

    local procedure LoadQueryData()
    var
        DupPhoneQuery: Query "Duplicate Mobile Phone";
    begin
        Clear(PhoneList);
        Clear(CountList);

        DupPhoneQuery.Open();
        while DupPhoneQuery.Read() do begin
            PhoneList.Add(DupPhoneQuery.MobilePhone);
            CountList.Add(DupPhoneQuery.CountPhone);
        end;
        DupPhoneQuery.Close();

        Rec.Reset();
        Rec.SetRange(Number, 1, PhoneList.Count());
    end;

    local procedure GetCurrentMobilePhone(): Text[30]
    begin
        if (Rec.Number >= 1) and (Rec.Number <= PhoneList.Count()) then
            exit(PhoneList.Get(Rec.Number));
        exit('');
    end;

    local procedure GetCurrentCount(): Integer
    begin
        if (Rec.Number >= 1) and (Rec.Number <= CountList.Count()) then
            exit(CountList.Get(Rec.Number));
        exit(0);
    end;
}