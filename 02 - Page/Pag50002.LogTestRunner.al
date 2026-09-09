page 50002 "Log_TestRunner"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LogTestRunner;
    Caption = 'Log Test Runner';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(UnitID; Rec.UnitID) { }
                field(UnitName; Rec.UnitName) { }
                field(MethodName; Rec.MethodName) { }
                field(Before; Rec.Before) { }
                field(After; Rec.After) { }
                field(Status; Rec.Status) { }
                field(Message; Rec.Message) { }
                field(Duration; Rec.Duration) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestRunner)
            {
                Caption = 'Run Test Runner';
                ApplicationArea = All;
                Image = TestDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::MyTestRunner)
                end;
            }
            action(AnyTestRunner)
            {
                Caption = 'Any Test Runner';
                ApplicationArea = All;
                Image = CalculateRemainingUsage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    EnabledTestCodeunit: Record "CAL Test Enabled Codeunit";
                    Object: Record AllObj;
                    CALTestMng: Codeunit "CAL Test Management";
                begin
                    Codeunit.Run(Codeunit::AnyTestRunner)
                end;
            }
            action(DeleteAllLog)
            {
                Caption = 'Delete All Logs';
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    LogTestRunner: Record LogTestRunner;
                begin
                    if not Confirm('Do you want to delete all log data?') then
                        exit;

                    LogTestRunner.DeleteAll();

                    Message('All log data has been deleted.');

                    CurrPage.Update(false);
                end;
            }
            action(ShowDuplicateMobilePhone)
            {
                Caption = 'Show Duplicate Mobile Phone';
                ApplicationArea = All;
                Image = Find;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    HandleFunction: Codeunit HandleFunction;
                begin
                    ShowDuplicate();
                end;
            }
            action(kuy)
            {
                Caption = 'Ivarn';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    testMessegeFilter();
                end;
            }
            action(ShowCustomerDataset)
            {
                Caption = 'ShowCustomerDataset';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    ShowCustomerReportDataset();
                end;
            }
            action(ShowFilter)
            {
                Caption = 'ShowFilter';
                ApplicationArea = All;
                Image = ShowSelected;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    ShowCustomerFilter();
                end;
            }
            action(TableCaption)
            {
                Caption = 'TableCaption';
                ApplicationArea = All;
                Image = Capacities;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    ALLOG: Record "AL Test Runner Log";
                    LogTestCodeunit: Record "LogTestCodeunit";
                begin
                    Message('%1', ALLOG.TableCaption());
                    Message('%1', LogTestCodeunit.TableCaption());
                end;
            }
            action(Cust_Filter)
            {
                Caption = 'Customer Filter';
                ApplicationArea = All;
                Image = UseFilters;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    RunCustomerFilter();
                end;
            }
        }
    }
    procedure ShowDuplicate()
    var
        DuplicateMobilePhone: Query "Duplicate Mobile Phone";
    begin
        DuplicateMobilePhone.Open();

        while DuplicateMobilePhone.Read() do
            Message(
                'Mobile Phone: %1\Count: %2',
                DuplicateMobilePhone.MobilePhone,
                DuplicateMobilePhone.CountPhone);

        DuplicateMobilePhone.Close();
    end;

    procedure testMessegeFilter()
    var
        XmlParameters: Text;
    // CustomerListPage: TestRequestPage "Customer - List"
    begin
        XmlParameters := Report.RunRequestPage(Report::"Customer - List");
        Message(XmlParameters);
        // <?xml version="1.0" standalone="yes"?><ReportParameters name="Customer - List" id="101"><DataItems><DataItem name="Customer">VERSION(1) SORTING(Field1) WHERE(Field1=1(10000..20000))</DataItem></DataItems></ReportParameters>
        // CustomerListPage.Customer.SetFilter("No.", '10000..20000');
    end;

    procedure ShowCustomerReportDataset()
    var
        XmlParameters: Text;
        LibraryReportDataset: Codeunit "Library - Report Dataset";
        Customer: Record Customer;
        CustomerNo: Variant;
        RecordVariant: Variant;
    begin
        // 1. เปิด Request Page
        XmlParameters := Report.RunRequestPage(Report::"Customer - List");
        Message('XmlParameters:\%1', XmlParameters);

        // Customer.SetFilter("No.", '10000..20000');
        // 2. Run Report และโหลด Dataset
        LibraryReportDataset.RunReportAndLoad(Report::"Customer - List", Customer, XmlParameters);

        Message('Total Dataset Rows = %1', LibraryReportDataset.RowCount());

        // 3. อ่าน Dataset ทีละ Row
        while LibraryReportDataset.GetNextRow() do begin

            if LibraryReportDataset.CurrentRowHasElement('Customer__No__') then begin

                LibraryReportDataset.GetElementValueInCurrentRow('Customer__No__', CustomerNo);

                // แสดงค่าจริง
                Message('Customer__No__ = %1', CustomerNo);
            end;
        end;
    end;

    procedure ShowCustomerFilter()
    var
        Customer: Record Customer;
    begin
        Customer.SetFilter("No.", '10000..20000');

        Message(
            'Filter = %1',
            Customer.GetFilter("No."));

        if Customer.FindSet() then
            repeat
                Message(
                    'Customer No. = %1',
                    Customer."No.");
            until Customer.Next() = 0;
    end;

    procedure RunCustomerFilter()
    var
        Customer: Record Customer;
        FilterPage: FilterPageBuilder;
        FilterResult: Text;
    begin
        // สร้าง Filter Page สำหรับ Table Customer
        FilterPage.AddRecord(Customer.TableCaption(), Customer);

        // เพิ่ม Field "No." ให้ผู้ใช้กรองได้
        FilterPage.AddField(Customer.TableCaption(), Customer."No.");

        // เปิด Filter Page ให้ผู้ใช้กรอก
        if FilterPage.RunModal() then begin
            // ถ้าผู้ใช้กด OK → ดึง Filter ที่กรอกออกมา
            FilterResult := FilterPage.GetView(Customer.TableCaption());
            Message('Filter ที่ผู้ใช้กรอกคือ: %1', FilterResult);

            Customer.SetView(FilterResult);
            if Customer.FindSet() then
                repeat
                    Message('Customer: %1', Customer."No.");
                until Customer.Next() = 0;
        end else
            Message('ผู้ใช้กด Cancel');
    end;
}
