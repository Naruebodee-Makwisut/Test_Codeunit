pageextension 50001 "Ext_TestRunner" extends "LSC Demo Role Cent."
{
    actions
    {
        addafter("Run POS")
        {
            action(TestTool)
            {
                Caption = 'Test Tool';
                ApplicationArea = All;
                RunObject = page "CAL Test Tool";
            }
            action(TestRunner)
            {
                // trigger OnAction()
                // var
                //     myInt: Integer;
                // begin
                //     Codeunit.Run(Codeunit::MyTestRunner)
                // end;
                Caption = 'Run Test Runner';
                ApplicationArea = All;
                RunObject = page Log_TestRunner;
            }
            // action(ShowDuplicateMobile)
            // {
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin

            //     end;
            // }
        }
    }
}