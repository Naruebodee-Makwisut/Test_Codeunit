tableextension 50100 "Sales Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        // สร้าง Field ใหม่ในตาราง Setup เพื่อผูกกับ No. Series ของเรา
        field(50100; "Test Codeunit"; Code[20])
        {
            Caption = 'Test Codeunit';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }
}