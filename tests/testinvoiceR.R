# invoiceR(invoice_yaml = file.path(ddir,"demo/invoice_demo.yaml"),
#          client_yaml = file.path(ddir,"demo/client.yaml"),
#          provider_yaml = file.path(ddir,"demo/provider.yaml"),
#          tempalte_rmd = file.path(ddir, "templates/invoice_template.Rmd"),
#          invdir = file.path(ddir, "demo"),
#          income_file = file.path(ddir, "demo/new_income.csv")) 

rmarkdown::render("./demo/ClientName_InvoiceGeneration.Rmd")

# ddir <- "."
# 
# invoiceR(invoice_yaml = file.path(ddir,"demo/invoice_demo.yaml"),
#          client_yaml = file.path(ddir,"demo/client.yaml"),
#          provider_yaml = file.path(ddir,"demo/provider.yaml"),
#          tempalte_rmd = file.path(ddir, "templates/invoice_template.Rmd"),
#          invdir = "~/",
#          income_file = file.path(ddir, "demo/new_income.csv")) 