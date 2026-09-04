codeunit 50118 TestFilterPageHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit HandleFunction;

    [Test]
    [HandlerFunctions('CustomerFilterPageHandler')]
    procedure TestCustomerFilterPage()
    begin
        HandleFunction.RunCustomerFilter();
    end;

    [FilterPageHandler]
    procedure CustomerFilterPageHandler(var CustomerRef: RecordRef): Boolean
    var
        NoField: FieldRef;
    begin
        NoField := CustomerRef.Field(1);

        NoField.SetFilter('TEST*');

        Assert.AreEqual('TEST*', NoField.GetFilter(), 'Customer No. filter is incorrect.');

        exit(true);
    end;
}