    SELECT
        sum(at."Transaction Amount (Credit - Debit)") as "CashFlow",
        a."Account Name" "Account Name",
        a."Account Type" "Account Type",
        a."Cash Flow Type" "Cash Flow Type",
        at."Transaction Date" "Transaction Date"
    FROM "Accounts" a
        LEFT JOIN "Accrual Transactions" at ON a."Account ID"  = at."Account ID"
    WHERE	 a."Cash Flow Type"  != '0'
    GROUP BY 2,
	 3,
	 4,
	  5
UNION ALL
    SELECT
        (sumif(a."Account Base Type"  in ( 'Income'  ), at."Transaction Amount (Debit - Credit)", 0) -sumif(a."Account Base Type"  in ( 'Expense'  ), at."Transaction Amount (Credit - Debit)", 0)) * -1 as "CashFlow",
        'Net Income' as "accountName",
        null,
        'A. Cash Flow From Operating Activities',
        at."Transaction Date" "Transaction Date"
    FROM "Accounts" a
        LEFT JOIN "Accrual Transactions" at ON a."Account ID"  = at."Account ID"
    GROUP BY 2,
	 3,
	 4,
	  5 
 
