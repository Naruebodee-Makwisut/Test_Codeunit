codeunit 50001 "CustomerTests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestInsertCustomer()
    var
        Customer: Record Customer;
    begin

        Customer.Init();
        Customer.Name := 'Test Customer';
        Customer.Insert();

        Assert.AreEqual('Test Customer', Customer.Name, 'Insert Complete');
    end;
}



