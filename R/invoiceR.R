require(rmarkdown)
require(yaml)

invoiceR <- function(invoice_yaml, client_yaml, provider_yaml, template_rmd, invdir, income_file=NULL){
  
  print(getwd())
  # setwd(invdir)
  
  #### Create invoice by rendering PDF using  rmarkdown ####
  df <- read_yaml(invoice_yaml)
  cl <- read_yaml(client_yaml)
  pr <- read_yaml(provider_yaml)
  
  render(input = template_rmd, envir = new.env(),         # invoice markdown template
         params = list(invoice=invoice_yaml,              # params for markdown
                       client=client_yaml,
                       provider=provider_yaml),
         output_file = sprintf("%s/%04d_%s_%s.pdf",  # output file
                               invdir,
                               df$invoice_number, 
                               gsub(" ", "", cl$client_name), 
                               format(Sys.time(),"%Y%m%d")))
  detach("package:kableExtra", unload=TRUE) # detach kableExtra
  
  #### Append (or save if first time) to yearly freelance income data ####
  if(is.null(income_file)){
    message("[MESSAGE]: No income_file input, SKIP adding invoice balance to income_file.") 
  }else{
    if(!file.exists(income_file)){
      indf <- data.frame(Date=format(Sys.time(),"%Y%m%d"), 
                                     InvoiceNumber=df$invoice_number, 
                                     Balnace=sum(df$unit_cost*df$quantity)-df$paid_to_date)
      write.csv(x = indf, file = income_file, row.names=F)
    }else{
      prevdf <- read.csv(income_file)
      if(sum(is.element(prevdf$InvoiceNumber, df$invoice_number))==0){
        # If this current invoice number don't already exist, append it to the csv file.
        indf <- data.frame(Date=format(Sys.time(),"%Y%m%d"), 
                           InvoiceNumber=df$invoice_number, 
                           Balnace=sum(df$unit_cost*df$quantity)-df$paid_to_date)
        write.table(x = indf, file= income_file, append = T, 
                    sep=',', 
                    row.names=F, 
                    col.names=F)
      }else{
        stop("[ERROR]: This invoice number is already in the income file. If you just need to regenerate the PDF invoice, remove income_file input from function to skip adding balance to income file.")
      }
    }
  }
  
}