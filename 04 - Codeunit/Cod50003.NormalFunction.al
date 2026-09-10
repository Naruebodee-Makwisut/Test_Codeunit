codeunit 50003 NormalFunction
{
    procedure DeleteCustomer(): Boolean
    begin
        if Confirm('Delete customer?') then
            exit(true);

        exit(false);
    end;

    procedure ShowMessage()
    begin
        Message('Completed.');
    end;

    procedure SelectOption(): Integer
    begin
        exit(StrMenu('Apple,Banana,Orange'));
    end;

    procedure CheckCustomer()
    var
        Notification: Notification;
    begin
        Notification.Message := 'Customer has been created.';
        Notification.Send();
    end;

    procedure OpenMicrosoftWebsite()
    begin
        Hyperlink('https://www.microsoft.com');
    end;

    procedure CheckCustomerBalance(Customer: Record Customer)
    var
        CustomerNotification: Notification;
    begin
        CustomerNotification.ID := CreateGuid();

        CustomerNotification.Message :=
            'Customer balance exceeds credit limit.';

        CustomerNotification.Send();

        if Customer.Balance <= Customer."Credit Amount" then
            CustomerNotification.Recall();
    end;

    procedure ChangeSessionLanguage()
    var
        SessionSettings: SessionSettings;
    begin
        SessionSettings.Init();
        SessionSettings.LanguageId(1033);
        SessionSettings.RequestSessionUpdate(false);
    end;

    procedure RunCustomerFilter()
    var
        Customer: Record Customer;
        FilterPage: FilterPageBuilder;
    begin
        FilterPage.AddRecord(Customer.TableCaption(), Customer);

        FilterPage.AddField(Customer.TableCaption(), Customer."No.");

        FilterPage.RunModal();
    end;

    procedure ShowDuplicate()
    var
        DuplicateMobilePhone: Query "Duplicate Mobile Phone";
    begin
        DuplicateMobilePhone.Open();

        while DuplicateMobilePhone.Read() do
            Message(
                'Mobile Phone: %1\Count: %2',
                DuplicateMobilePhone.MobilePhone,
                DuplicateMobilePhone.CountPhone);

        DuplicateMobilePhone.Close();
    end;
}