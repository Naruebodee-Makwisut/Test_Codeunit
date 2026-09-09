codeunit 50131 "Customer Report Test"
{
    Subtype = Test;

    [Test]
    [HandlerFunctions('CustomerFilterHandler')]
    procedure TestCustomerFilter()
    var
        HandleFunction: Codeunit NormalFunction;
        Customer: Record Customer;
        FilterPage: FilterPageBuilder;
    begin
        HandleFunction.RunCustomerFilter();

        FilterPage.AddField('Customer', Customer."No.");
    end;

    [FilterPageHandler]
    procedure CustomerFilterHandler(var Record1: RecordRef): Boolean
    begin
        // จัดการ Filter Page
        exit(true);
    end;

    procedure TestCode1()
    var
        FilterPage: FilterPageBuilder;
        Customer: Record Customer;
    begin
        FilterPage.AddField(
            'Customer No.',
            Customer."No."
        );

        FilterPage.RunModal();
    end;
}