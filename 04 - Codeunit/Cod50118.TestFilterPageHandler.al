codeunit 50118 TestFilterPageHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit NormalFunction;

    [Test]
    [HandlerFunctions('CustomerFilterPageHandler')]
    procedure TestCustomerFilterPage()
    begin
        // HandleFunction.RunCustomerFilter();
        RunCustomerFilter();
    end;

    [FilterPageHandler]
    procedure CustomerFilterPageHandler(var CustomerRef: RecordRef): Boolean
    var
        NoField: FieldRef;
    begin
        NoField := CustomerRef.Field(1);

        // NoField.SetFilter('TEST1*');

        Assert.AreEqual('TN*', NoField.GetFilter(), 'Customer No. filter is incorrect.');

        exit(true);
    end;

    procedure RunCustomerFilter()
    var
        Customer: Record Customer;
        FilterPage: FilterPageBuilder;
    begin
        Customer.SetFilter("No.", 'TN*');
        FilterPage.AddRecord(Customer.TableCaption(), Customer);
        // Message('Filter = %1', Customer.GetFilter("No."));

        FilterPage.AddField(Customer.TableCaption(), Customer."No.");

        FilterPage.RunModal();
    end;
}