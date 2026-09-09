codeunit 50005 TestItemInStore
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure Report_Run_With_Data()
    var
        ItemDistribution: Record "LSC Item Distribution";
    begin
        // Arrange

        ItemDistribution.Reset();
        ItemDistribution.SetRange(Status, ItemDistribution.Status::Active);

        // Act
        Report.Run(Report::"LSC Item in Store", false, false, ItemDistribution);

        // Assert
        Assert.IsTrue(true, '');
    end;

    [Test]
    procedure Report_Filter_By_Store()
    var
        ItemDistribution: Record "LSC Item Distribution";
    begin

        ItemDistribution.SetRange(Code, 'STORE01');

        Report.Run(Report::"LSC Item in Store", false, false, ItemDistribution);
    end;

    [Test]
    procedure Report_Filter_Item()
    var
        Item: Record Item;
    begin

        Item.SetRange("No.", '1000');

        Report.Run(
            Report::"LSC Item in Store", false, false);

    end;
}