codeunit 50117 TestSessionSettingsHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit NormalFunction;

    [Test]
    [HandlerFunctions('SessionSettingsHandler')]
    procedure TestChangeSessionLanguage()
    begin
        ChangeSessionLanguage();
    end;

    [SessionSettingsHandler]
    procedure SessionSettingsHandler(
        var SessionSettings: SessionSettings): Boolean
    begin
        Assert.AreEqual(1033, SessionSettings.LanguageId(), 'Language ID is incorrect.');

        exit(true);
    end;

    procedure ChangeSessionLanguage()
    var
        SessionSettings: SessionSettings;
    begin
        SessionSettings.Init();
        SessionSettings.LanguageId(1033);
        SessionSettings.RequestSessionUpdate(false);
    end;


}