library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mikes Super Awesome Code List Builder"),
  
  # Sidebar with selection options
  sidebarLayout(
    sidebarPanel(
       selectInput('selected_icd93',  'Select ICD-9 Codes (3-digits)',  choices=NULL, multiple=TRUE, selectize=TRUE),
       selectInput('selected_icd9',  'Select ICD-9 Codes',  choices=NULL, multiple=TRUE, selectize=TRUE),
       #regexSelectUI(id = "selected_icd9", label = 'Selct ICD-9 Codes', choices = NULL, multiple=TRUE),
       selectInput('selected_icd103', 'Select ICD-10 Codes (3-digits)', choices=NULL, multiple=TRUE, selectize=TRUE),
       selectInput('selected_icd10', 'Select ICD-10 Codes', choices=NULL, multiple=TRUE, selectize=TRUE),
       
       selectInput('selected_hcpcs', 'Select HCPCS Codes',  choices=NULL, multiple=TRUE, selectize=TRUE),
       
       selectInput('selected_gennme', 'Select NDC Codes by Generic Name',  choices=NULL, multiple=TRUE, selectize=TRUE),
       selectInput('selected_prodnme', 'Select NDC Codes by Brand Name',  choices=NULL, multiple=TRUE, selectize=TRUE),
       selectInput('selected_THRCLSD', 'Select NDC Codes by Therapeutic Class',  choices=NULL, multiple=TRUE, selectize=TRUE),
       selectInput('selected_routes', 'Select NDC Codes by Route',  choices=NULL, multiple=TRUE, selectize=TRUE)
    ),

    # Show a plot of the generated distribution
    mainPanel("Current Selections",
       tabsetPanel(
         id = 'code_tables',
         tabPanel("ICD-9 Diagnosis Codes", DT::dataTableOutput("icd9_table")),
         tabPanel("ICD-10 Diagnosis Codes", DT::dataTableOutput("icd10_table")),
         tabPanel("HCPCS Injection Codes", DT::dataTableOutput("hcpcs_table")),
         tabPanel("NDC Medication Codes", DT::dataTableOutput("ndc_table"), 
                  hr(), 
                  "List of Distinct Generic Names only:", DT::dataTableOutput("ndc_gentable"))
       ),
       downloadButton("downloadData", "Download")
    )
  )
))