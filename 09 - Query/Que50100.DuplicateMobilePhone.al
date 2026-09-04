query 50100 "Duplicate Mobile Phone"
{
    QueryType = Normal;

    elements
    {
        dataitem(MemberContact; "LSC Member Contact")
        {
            DataItemTableFilter = "Mobile Phone No." = filter('<>''''');
            column(MobilePhone; "Mobile Phone No.") { }
            column(CountPhone) { Method = Count; ColumnFilter = CountPhone = filter('> 1'); }
        }

    }
}
