codeunit 50131 "Customer Report Test"
{
    Subtype = Test;

    [Test]
    [HandlerFunctions('CustomerFilterHandler')]
    procedure TestCustomerFilter()
    var
        HandleFunction: Codeunit HandleFunction;
    begin
        HandleFunction.RunCustomerFilter();
    end;

    [FilterPageHandler]
    procedure CustomerFilterHandler(var Record1: RecordRef): Boolean
    begin
        // จัดการ Filter Page
        exit(true);
    end;
}