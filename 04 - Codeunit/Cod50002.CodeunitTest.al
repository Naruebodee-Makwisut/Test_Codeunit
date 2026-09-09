codeunit 50002 CodeunitTest
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

    [Test]
    procedure TestAdd()
    var
        Result: Integer;
    begin
        // Result := Calculator.Add(5, 10);

        Assert.AreEqual(15, Result, 'Addition failed');
    end;

    [Test]
    procedure TestFail()
    begin
        Assert.AreEqual(10, 20, 'Value is incorrect');
    end;

    [Test]
    procedure TestError()
    begin
        Error('This is my test error');
    end;
}