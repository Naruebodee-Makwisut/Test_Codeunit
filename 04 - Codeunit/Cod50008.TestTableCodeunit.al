codeunit 50008 TestTableCodeunit

{
    Subtype = Test;

    var
        CustomerManagement: Codeunit "TableManagement";
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestCreateCustomer()
    var
        Customer: Record Customer;
    begin
        CustomerManagement.CreateCustomer('TEST001', 'Test Customer');

        Customer.Get('TEST001');

        Assert.AreEqual('TEST001', Customer."No.", 'Customer No. is incorrect.');

        Assert.AreEqual('Test Customer', Customer.Name, 'Customer Name is incorrect.');
    end;

    //Modify
    [Test]
    procedure TestRenameCustomer()
    var
        Customer: Record Customer;
    begin
        CustomerManagement.CreateCustomer('TEST002', 'Old Name');

        CustomerManagement.RenameCustomer('TEST002', 'New Name');

        Customer.Get('TEST002');

        Assert.AreEqual('New Name', Customer.Name, 'Customer name was not updated.');
    end;

    //4.Error
    [Test]
    procedure TestCreateDuplicateCustomer()
    begin
        CustomerManagement.CreateCustomer('TEST003', 'First Customer');

        Assert.ExpectedError('Customer TEST003 already exists.');

        CustomerManagement.CreateCustomer('TEST003', 'Second Customer');
    end;

    //5
    [Test]
    procedure TestRenameNonExistingCustomer()
    begin
        Assert.ExpectedError('Customer TEST999 does not exist.');
        CustomerManagement.RenameCustomer('TEST999', 'New Name');

    end;

    //6
    [Test]
    procedure TestCreateCustomerFail()
    var
        Customer: Record Customer;
    begin
        CustomerManagement.CreateCustomer('TEST004', 'Test Customer');

        Customer.Get('TEST004');

        Assert.AreEqual('Wrong Name', Customer.Name, 'Customer Name is incorrect.');
    end;

    [Test]
    procedure TestCustomerNotExist()
    var
        Customer: Record Customer;
    begin
        Assert.ExpectedError('Customer TEST999 does not exist.');

        if not Customer.Get('TEST999') then
            Error('Customer TEST999 does not exist.');
    end;

}