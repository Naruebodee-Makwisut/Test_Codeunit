report 50001 "Purchase_Header-Line"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    Caption = 'Purchase_Header';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.");

            column(No_Header; "No.") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Pay_to_Address; "Pay-to Address") { }
            column(ComName; Company_In.Name) { }
            column(ComAddress; Company_In.Address + Company_In."Address 2" + Company_In.City) { }
            column(comPhone_No; Company_In."Phone No.") { }
            column(balance; balance)
            { }
            column(Company_In; Company_In.Picture) { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = FIELD("No.");

                column(No_Line; "No.")
                {
                }
                column(Description; "Description")
                {
                }
                column(Quantity; "Quantity")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Amount; "Amount")
                {
                }
                column(Running; "Running") { }

                column(TotalAmount; "TotalAmount")
                {
                }

                trigger OnPreDataItem()
                var
                begin
                    Clear(Sumrunning);
                    // Clear(TotalAmount);
                    // Clear(Running);
                    MaxLine := 31;
                end;

                trigger OnAfterGetRecord()
                var
                begin

                    Running += 1;
                    Sumrunning += Running;
                    TotalAmount += "Purchase Line".Amount;

                end;


            }

            dataitem(EmptyLine; Integer)
            {
                DataItemTableView = sorting(Number);
                column(Number_EmptyLine; EmptyLine.Number)
                {
                }
                column(Number; Number) { }
                trigger OnPreDataItem()
                var
                begin
                    MaxLine := 31;
                    // if (Running mod MaxLine) = 0 then
                    //     CurrReport.Break()
                    // // EmptyLine.SetRange(Number, 1, 0)
                    // else begin
                    //     AddLine := MaxLine - (Running mod MaxLine);
                    //     EmptyLine.SetRange(Number, 1, AddLine);
                    // end;
                    if (Running <> 0) and ((Running mod MaxLine) = 0) then //2 % 30 = ?  เพิ่ม (Running <> 0) and 
                        SetRange(Number, 1, 0)
                    else begin
                        AddLine := MaxLine - (Running mod MaxLine);
                        if Running = 0 then
                            AddLine := 30;
                        SetRange(Number, 1, AddLine);
                    end;

                end;
            }

            trigger OnPreDataItem()
            begin
                Company_In.Get();
                Company_In.CalcFields(Picture);
                ComName := Company_In.Name;
                comPhone_No := Company_In."Phone No.";
                ComAddress := Company_In.Address + Company_In."Address 2" + Company_In.City;
                // comAddress1 := Company_In.Address;
                // comAddress2 := Company_In."Address 2";
                // comCity := Company_In.City;

                if period then begin
                    if (star_date <> 0D) and (end_date <> 0D) then begin
                        SetRange("Order Date", "star_date", "end_date");
                    end else
                        Error('กรุณากรอกข้อมูล');
                end else begin
                    if (Dates <> 0D) then begin
                        SetRange("Order Date", Dates);
                    end else
                        Error('กรุณากรอกข้อมูล');
                end;
            end;


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                venberTB.Get("Purchase Header"."Pay-to Vendor No.");
                venberTB.CalcFields("Balance (LCY)");
                balance := venberTB."Balance (LCY)";
                Clear(TotalAmount);
                Clear(Running);
                // Clear(AddLine);
            end;
        }
    }


    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    group("Date Filter 1")
                    {
                        field(period; period)
                        {
                            ApplicationArea = all;
                            Caption = 'Period';
                            trigger OnValidate()
                            begin
                                if period then
                                    at_Date := false
                                else
                                    at_Date := true;
                            end;

                        }
                        group("Period Date")
                        {
                            field(star_date; star_date)
                            {
                                ApplicationArea = all;
                                Caption = 'Star Date';
                                Enabled = period;
                            }
                            field(end_date; end_date)
                            {
                                ApplicationArea = all;
                                Caption = 'End Date';
                                Enabled = period;
                            }
                        }
                    }

                    group("Date Filter 2")
                    {
                        field(at_Date; at_Date)
                        {
                            ApplicationArea = all;
                            Caption = 'At Date';
                            // Editable = Editat_date;
                            // Visible = period;
                            trigger OnValidate()
                            begin
                                if at_Date then
                                    period := false
                                else
                                    period := true;

                            end;

                        }

                        group("At Date Filter")
                        {
                            field(Date; Dates)
                            {
                                ApplicationArea = All;
                                Caption = 'Date';
                                Enabled = at_Date;
                            }
                        }
                    }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }

        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            period := true;
            at_Date := false;
            Dates := Today;

        end;


    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = '07 - ReportLayout/ReprotHeader-Line2.rdl';
        }
    }

    var
        Company_In: Record "Company Information";
        ComName: Text[100];
        // comAddress1: Text[100];
        // comAddress2: Text[100];
        // comCity: Text[100];
        comPhone_No: Text[100];
        ComAddress: Text[100];
        // comPicture: 
        venberTB: Record Vendor;
        balance: Decimal;
        myInt: Integer;
        Running: Decimal;
        Sumrunning: Decimal;
        TotalAmount: Decimal;
        MaxLine: Integer;
        AddLine: Integer;
        star_date: Date;
        end_date: Date;
        period: Boolean;
        at_Date: Boolean;
        Dates: Date;
}