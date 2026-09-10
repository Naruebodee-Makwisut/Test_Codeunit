codeunit 50132 TestReportHandler
{
    Subtype = Test;
    RequiredTestIsolation = Codeunit;

    var
        Assert: Codeunit "Library Assert";
        XmlParameters: Text;
        LibraryReportDataset: Codeunit "Library - Report Dataset";
        RecordVariant: Variant;
        CustomerTB: Record Customer;

    [Test]
    [HandlerFunctions('CustomerRequestHandler')]
    procedure TestRequestReport()
    begin
        XmlParameters := Report.RunRequestPage(Report::"Customer - Sales List");
    end;

    [Test]
    [HandlerFunctions('SalesReportHandler')]
    procedure TestRunReport()
    begin
        LibraryReportDataset.RunReportAndLoad(Report::"Customer - Sales List", RecordVariant, XmlParameters);
    end;

    [RequestPageHandler]
    procedure CustomerRequestHandler(var RequestPage: TestRequestPage "Customer - Sales List")
    begin
        RequestPage.Customer.SetFilter("No.", '10000');
        RequestPage.OK.Invoke();
    end;

    [ReportHandler]
    procedure SalesReportHandler(var CustSalesList: Report "Customer - Sales List")
    var
        Customer: Record Customer;
    begin
        LibraryReportDataset.AssertElementWithValueExists('Customer__No__', '10000');
    end;

}