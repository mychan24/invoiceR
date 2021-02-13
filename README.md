# invoiceR

An R Markdown based invoicing system that (1) creates a PDF invoice and (2) input billed balance into an income csv file. 

The input data are 3 `yaml` files, defining:
	
* client
* provider
* invoice
	+ invoice_number: recommened to use <YEAR><4-digit-reset-each-year>. e.g., the first invoice in 2021 would have an invoice number of 20210001. 
	+ line_items: task performed
	+ item_descrip: description of task (treat this as a note section)
	+ unit_cost: how much is charged for each task
	+ quantity: how many times was this task performed 
	+ paid_to_date: how much has been paid for this invoice so far (usually it's zero). 

The output PDF will include the following:

* The `sub_total` is `sum(unit_cost * quantity)` will be automatically calculated. 
* The `balance_due` is the `sub_total`-`paid_to_date`
* Client info (e.g., name, address)
* Provider info (e.g., name, address, phone, email)


