SELECT
    "Accounts"."Account Code" as 'Account ID',
    "Accounts"."Account Name" as 'Account Description',
    "Bills"."Bill Number" as 'Bill Number',
    "Vendors"."Vendor Name" as 'Transaction Detail',
    "Bill Item"."Description" as 'Transaction Description',
    "Bill Item"."Total (BCY)" as 'Debit Amount'
FROM "Accounts"
    LEFT JOIN "Bill Item" ON "Accounts"."Account ID"  = "Bill Item"."Account ID"
    LEFT JOIN "Customers" ON "Customers"."Customer ID"  = "Bill Item"."Customer ID"
    LEFT JOIN "Bills" ON "Bills"."Bill ID"  = "Bill Item"."Bill ID"
    LEFT JOIN "Vendors" ON "Vendors"."Vendor ID"  = "Bills"."Vendor ID"
WHERE	 "Bill Item"."Billable Status"  NOT IN ( 'Void'  , 'Draft'  , ''  )
