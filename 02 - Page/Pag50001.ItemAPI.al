page 50001 "Item API"
{
    PageType = API;
    Caption = 'Item API';
    APIPublisher = 'mycompany';
    APIGroup = 'items';
    APIVersion = 'v1.0';
    EntityName = 'item';
    EntitySetName = 'items';
    SourceTable = Item;
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { Caption = 'Id'; }
            field(number; Rec."No.") { Caption = 'Number'; }
            field(name; Rec.Description) { Caption = 'Name'; }
            field(price; Rec."Unit Price") { Caption = 'Price'; }
        }
    }
}
