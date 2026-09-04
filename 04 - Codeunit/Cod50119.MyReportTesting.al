codeunit 50119 MyReportTesting
{
    Subtype = Test;

    [Test]
    [HandlerFunctions('RemittanceAdviceJournalRequestPageHandler')]
    procedure TestingReports()
    var
        XmlParameters: Text;
        LibraryReportDataset: Codeunit "Library - Report Dataset";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        // CreateRemittanceAdvices();
        // Commit(); // required after data changes and before calling RunRequestPage

        // Run the Report Remittance Advice - Journal. 
        XmlParameters := Report.RunRequestPage(Report::"Remittance Advice - Journal");
        LibraryReportDataset.RunReportAndLoad(Report::"Remittance Advice - Journal", GenJournalLine, XmlParameters);

        // Verifying Total Amount on Report. 
        LibraryReportDataset.AssertElementWithValueExists('Amt_GenJournalLine', GenJournalLine.Amount);


        LibraryReportDataset.AssertElementWithValueNotExist('Amt_GenJournalLine', 0);

    end;

    [RequestPageHandler]
    procedure RemittanceAdviceJournalRequestPageHandler(var RemittanceAdviceJournal: TestRequestPage "Remittance Advice - Journal")
    begin
        RemittanceAdviceJournal.FindVendors.SetFilter("Posting Date", '..T');
    end;
}