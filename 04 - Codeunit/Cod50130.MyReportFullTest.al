codeunit 50130 MyReportFullTest
{
    Subtype = Test;
    RequiredTestIsolation = Codeunit;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    [HandlerFunctions('CustomerListRequestPageHandler')]
    procedure TestCustomerListReport()
    var
        XmlParameters: Text;
        XmlParametersTest: Text;
        LibraryReportDataset: Codeunit "Library - Report Dataset";
        Customer: Record Customer;
        // CustomerNo: Text;
        CustomerNo: Variant;
        RecordVariant: Variant;
        CustomerTB: Record Customer;
    begin

        XmlParameters := Report.RunRequestPage(Report::"Customer - List");
        LibraryReportDataset.RunReportAndLoad(Report::"Customer - List", RecordVariant, XmlParameters);

        Customer.SetFilter("No.", '10000..20000');

        if Customer.FindSet() then
            repeat
                // เอา Customer No. ไปเทียบกับ Dataset
                LibraryReportDataset.AssertElementWithValueExists(
                    'Customer__No__',
                    Customer."No.");
            until Customer.Next() = 0;

        // Customer.Get('10000');
        // LibraryReportDataset.AssertElementWithValueExists('Customer__No__', Customer."No.");
        LibraryReportDataset.AssertElementWithValueNotExist('Customer__No__', '30000');
    end;


    [RequestPageHandler]
    procedure CustomerListRequestPageHandler(var CustomerListPage: TestRequestPage "Customer - List")
    begin
        CustomerListPage.Customer.SetFilter("No.", '10000..20000');

        // กด OK เพื่อยืนยัน
        CustomerListPage.OK.Invoke();
    end;
}
