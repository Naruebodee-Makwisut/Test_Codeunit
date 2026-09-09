codeunit 50115 TestHyperLinkHandler
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        HandleFunction: Codeunit NormalFunction;

    [Test]
    [HandlerFunctions('HyperLinkHandler')]
    procedure TestOpenMicrosoftWebsite()
    begin
        OpenMicrosoftWebsite();
    end;

    [HyperLinkHandler]
    procedure HyperLinkHandler(Link: Text[1024])
    begin
        Assert.AreEqual('https://www.microsoft.com', Link, 'Hyperlink is incorrect.');
    end;

    procedure OpenMicrosoftWebsite()
    begin
        Hyperlink('https://www.microsoft.com');
    end;

}
