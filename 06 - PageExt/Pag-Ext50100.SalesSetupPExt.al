pageextension 50100 "Sales Setup P_Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Price List Nos.")
        {
            field("Test Codeunit"; Rec."Test Codeunit")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}