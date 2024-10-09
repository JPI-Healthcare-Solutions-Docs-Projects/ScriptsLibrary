    SELECT
        "Sales Persons"."Name" as 'Sales Person Name',
        "Category"."Category Name" as 'Category Name',
        "Items"."Item Name" as 'SKU',
        "Invoices"."Invoice Date" as 'Date',
        sum("Invoice Items"."Quantity") as 'Invoice Item Quantity',
        count_distinct("Invoices"."Invoice ID") as 'Invoice Count',
        sum("Invoice Items"."Sub Total (BCY)") as 'Invoice Sales Without Tax',
        sum("Invoice Items"."Total (BCY)") as 'Invoice Sales With Tax',
        null as 'Credit Note Item Quantity',
        null as 'Credit Note Count',
        null as 'Credit Note Sales',
        null as 'Credit Note Sales With Tax',
        sum("Invoice Items"."Sub Total (BCY)") as 'Total Sales Without Tax',
        sum("Invoice Items"."Total (BCY)") as 'Total Sales With Tax',
        'Invoices' as "Type"
    FROM "Sales Persons"
        LEFT JOIN "Invoices" ON "Sales Persons"."Sales Person ID"  = "Invoices"."Sales Person ID"
        LEFT JOIN "Invoice Items" ON "Invoice Items"."Invoice ID"  = "Invoices"."Invoice ID"
        LEFT JOIN "Items" ON "Items"."Item ID"  = "Invoice Items"."Product ID"
        LEFT JOIN "Category" ON "Category"."Category ID"  = "Items"."Category ID"
    WHERE	 "Invoices"."Status"  NOT IN ( 'Void'  , 'Draft'  , ''  )
    GROUP BY 1,
	 2,
	 3,
	  4
UNION ALL
    SELECT
        "Sales Persons"."Name" as 'Sales Person Name',
        "Category"."Category Name" as 'Category Name',
        "Items"."Item Name" as 'SKU',
        "Credit Notes"."Credit Note Date",
        null,
        null,
        null,
        null,
        sum("Credit Note Items"."Quantity") as 'Credit Note Item Quantity',
        count_distinct("Credit Notes"."CreditNotes ID") as 'Credit Note Count',
        sum("Credit Note Items"."Sub Total") as 'Credit Note Sales Without Tax',
        sum("Credit Note Items"."Total") as 'Credit Note Sales With Tax',
        sum(-1 * "Credit Note Items"."Sub Total"),
        sum(-1 * "Credit Note Items"."Total"),
        'Credit Notes' as "Type"
    FROM "Sales Persons"
        LEFT JOIN "Credit Notes" ON "Sales Persons"."Sales Person ID"  = "Credit Notes"."Sales Person ID"
        LEFT JOIN "Credit Note Items" ON "Credit Note Items"."CreditNotes ID"  = "Credit Notes"."CreditNotes ID"
        LEFT JOIN "Items" ON "Items"."Item ID"  = "Credit Note Items"."Product ID"
        LEFT JOIN "Category" ON "Category"."Category ID"  = "Items"."Category ID"
    WHERE	 "Credit Notes"."Credit Note Status"  NOT IN ( 'Void'  , 'Draft'  , ''  )
    GROUP BY 1,
	 2,
	 3,
	  4 
 
