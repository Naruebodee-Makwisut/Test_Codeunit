page 50003 "AL Test Runner Logs"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "AL Test Runner Log";
    SourceTableView = sorting("Entry No.") order(descending);
    Caption = 'AL Test Runner Logs';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Execution Date-Time"; Rec."Execution Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Test Suite Name"; Rec."Test Suite Name")
                {
                    ApplicationArea = All;
                }
                field("Codeunit ID"; Rec."Codeunit ID")
                {
                    ApplicationArea = All;
                }
                field("Codeunit Name"; Rec."Codeunit Name")
                {
                    ApplicationArea = All;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = All;
                }
                field("Run Status"; Rec."Run Status")
                {
                    ApplicationArea = All;
                }
                field("Execution Time (ms)"; Rec."Execution Time (ms)")
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }
                field("Executed By"; Rec."Executed By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}