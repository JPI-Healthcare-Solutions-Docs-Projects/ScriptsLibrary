    SELECT
        "Sales Persons"."Name" as 'Sales Person Name',
        "Customers"."Customer Name" as 'Customer Name',
        "Invoices"."Invoice Date" as 'Date',
        if_null("Customer Addresses"."Billing State", "Customer Addresses"."Billing Country") as 'State',
        "Invoices"."Status" as 'Status',
        count("Invoices"."Invoice ID") as 'Invoice Count',
        sum("Invoices"."Sub Total (BCY)") as 'Invoice Sales Without Tax',
        sum("Invoices"."Total (BCY)") as 'Invoice Sales With Tax',
        null as 'Credit Note Count',
        null as 'Credit Note Sales',
        null as 'Credit Note Sales With Tax',
        sum("Invoices"."Sub Total (BCY)") as 'Sales Without Tax',
        sum("Invoices"."Total (BCY)") as 'Sales'
    FROM "Sales Persons"
        LEFT JOIN "Invoices" ON "Sales Persons"."Sales Person ID"  = "Invoices"."Sales Person ID"
        LEFT JOIN "Customers" ON "Customers"."Customer ID"  = "Invoices"."Customer ID"
        LEFT JOIN "Customer Addresses" ON "Customer Addresses"."Address ID"  = "Invoices"."Address ID"
    WHERE	 "Invoices"."Status"  NOT IN ( 'Void'  , 'Draft'  , ''  )
    GROUP BY 1,
	 2,
	 3,
	 4,
	  5
UNION ALL
    SELECT
        "Sales Persons"."Name" as 'Sales Person Name',
        "Customers"."Customer Name" as 'Customer Name',
        "Credit Notes"."Credit Note Date",
        if_null("Customer Addresses"."Billing State", "Customer Addresses"."Billing Country") as 'State',
        null,
        null,
        null,
        null,
        count("Credit Notes"."CreditNotes ID") as 'Credit Note Count',
        sum("Credit Notes"."Sub Total (BCY)") as 'Credit Note Sales Without Tax',
        sum("Credit Notes"."Total (BCY)") as 'Credit Note Sales With Tax',
        sum(-1 * "Credit Notes"."Sub Total (BCY)"),
        sum(-1 * "Credit Notes"."Total (BCY)")
    FROM "Sales Persons"
        LEFT JOIN "Credit Notes" ON "Sales Persons"."Sales Person ID"  = "Credit Notes"."Sales Person ID"
        LEFT JOIN "Customers" ON "Customers"."Customer ID"  = "Credit Notes"."Customer ID"
        LEFT JOIN "Customer Addresses" ON "Customer Addresses"."Address ID"  = "Credit Notes"."Address ID"
    WHERE	 "Credit Notes"."Credit Note Status"  NOT IN ( 'Void'  , 'Draft'  , ''  )
    GROUP BY 1,
	 2,
	 3,
	 4,
	  5 
 
