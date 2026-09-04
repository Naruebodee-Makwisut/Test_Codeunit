page 50004 TestInsertPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = TestInsert;
    CardPageId = TestInsertCard;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID) { }
                field(Name; Rec.Name) { }
                field(Date; Rec.Date) { }
                field(Time; Rec.Time) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}