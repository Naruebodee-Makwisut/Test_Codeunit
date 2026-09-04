codeunit 50120 TestEvent
{
    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    // local procedure CustomerInserted(var Rec: Record Customer)
    // var
    //     CustomerLog: Record "Customer";
    // begin
    //     CustomerLog.Init();
    //     CustomerLog."No." := 'testt01';
    //     CustomerLog."Last Modified Date Time" := CurrentDateTime;
    //     CustomerLog.Insert();
    // end;
}
