codeunit 50009 "TableManagement"
{
    procedure CreateCustomer(CustomerNo: Code[20]; CustomerName: Text[100])
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustomerNo) then
            Error('Customer %1 already exists.', CustomerNo);

        Customer.Init();
        Customer."No." := CustomerNo;
        Customer.Validate(Name, CustomerName);
        Customer.Insert();
    end;

    procedure RenameCustomer(CustomerNo: Code[20]; NewName: Text[100])
    var
        Customer: Record Customer;
    begin
        if not Customer.Get(CustomerNo) then
            Error('Customer %1 does not exist.', CustomerNo);

        Customer.Validate(Name, NewName);
        Customer.Modify();
    end;
}