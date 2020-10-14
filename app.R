#install.packages(c("shinydashboard", "shiny","openxlsx","data.table","DT", "shinyjs"))

library(shiny)
library(shinydashboard)
library(openxlsx)
library(data.table)
library(DT)
library(feather)
library(shinyjs)

# Set zip environment variable to save out the xlsx files
#Sys.setenv(R_ZIPCMD= "zip.exe")

# Mike's testing environment
#icd9 <- data.table(read.xlsx("data\\ICD-9-CM-v32-master-descriptions\\CMS32_DESC_LONG_SHORT_DX.xlsx"))

# Read in all source data tables
# if (update_datasets == TRUE){
#   icd9 <- data.table(read.xlsx('data\\CMS32_DESC_LONG_SHORT_DX.xlsx'))
#   icd9$item <- paste(icd9$DIAGNOSIS.CODE, ' - ', icd9$SHORT.DESCRIPTION)
#   icd9$item2 <- substr(icd9$DIAGNOSIS.CODE,1,2)
#   icd9$item3 <- substr(icd9$DIAGNOSIS.CODE,1,3)
#   icd9$item4 <- substr(icd9$DIAGNOSIS.CODE,1,4)
#   
#   icd10 <- data.table(read.xlsx("data\\icd10cm_order_2015_excelformat.xlsx"))
#   icd10$VALUE <- trimws(icd10$VALUE, which = "right")
#   icd10$item <- paste(icd10$VALUE, ' - ', icd10$SHORT.DESCRIPTION)
#   icd10$item2 <- substr(icd10$VALUE,1,2)
#   icd10$item3 <- substr(icd10$VALUE,1,3)
#   icd10$item4 <- substr(icd10$VALUE,1,4)
#   
#   icd9_10GEMS <- data.table(read.table("data\\2015_I9gem.txt", colClasses = c(rep("character", 3))))
#   icd10_9GEMS <- data.table(read.table("data\\2015_I10gem.txt", colClasses = c(rep("character", 3))))
#   
#   hcpcs <- data.table(read.xlsx("data\\HCPC2018_CONTR_ANWEB.xlsx"))
#   hcpcs$item <- paste(hcpcs$HCPC, ' - ', hcpcs$SHORT.DESCRIPTION)
#   
#   redbook <- fread(file="data\\redbook.csv", sep = ",", header= TRUE, colClasses = list(characer=c(1:33)))
#   redbook$ROADS <- ifelse(redbook$ROADS == '', 'Unspecified Route', redbook$ROADS)
#   
#   drg <- fread(file="data\\drg34g.csv", sep=",", header=FALSE, colClasses = c("numeric", "character"), col.names = c("DRG", "LABEL"))
#   drg$DRG_VALUE <- formatC(drg$DRG, width=3, flag="0")
#   drg$DRG_VALUE2 <- substr(drg$DRG_VALUE, 1,2)
#   drg$item <- paste(drg$drg_value, ' - ', drg$LABEL)
#   
#  icd_meddra <- fread(file="data/icd_to_meddra_version_230.csv", sep="$", header=TRUE)
#
#   # Save all datasets to feather format for efficiency!
#   datasets <- list(hcpcs = hcpcs, icd10 = icd10, icd10_9GEMS = icd10_9GEMS, icd9 = icd9, 
#                    icd9_10GEMS=icd9_10GEMS, redbook=redbook, drg=drg, meddra=icd_medddra)
#   names_list <- names(datasets)
#   
#   for (i in seq_along(datasets)) {
#     write_feather(datasets[[i]], path=paste0("data\\", names_list[i], ".feather"))
#   }
#   rm(datasets, names_list, hcpcs, icd10, icd10_9GEMS, icd9, icd9_10GEMS, redbook, drg, icd_meddra, i)
# }

##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
update_datasets <- FALSE

# Read in all source data tables
if (update_datasets == TRUE){
  icd9 <- data.table(read.xlsx('data/ICD-9-CM-v32-master-descriptions/CMS32_DESC_LONG_SHORT_DX.xlsx'))
  icd9$item <- paste(icd9$DIAGNOSIS.CODE, ' - ', icd9$SHORT.DESCRIPTION)
  icd9$item2 <- substr(icd9$DIAGNOSIS.CODE,1,2)
  icd9$item3 <- substr(icd9$DIAGNOSIS.CODE,1,3)
  icd9$item4 <- substr(icd9$DIAGNOSIS.CODE,1,4)
  
  icd10 <- data.table(read.xlsx("data/2015-code-descriptions/icd10cm_order_2015_excelformat.xlsx"))
  icd10$VALUE <- trimws(icd10$VALUE, which = "right")
  icd10$item <- paste(icd10$VALUE, ' - ', icd10$SHORT.DESCRIPTION)
  icd10$item2 <- substr(icd10$VALUE,1,2)
  icd10$item3 <- substr(icd10$VALUE,1,3)
  icd10$item4 <- substr(icd10$VALUE,1,4)
  
  icd9_10GEMS <- data.table(read.table("data/DiagnosisGEMs_2015/2015_I9gem.txt", colClasses = c(rep("character", 3))))
  icd10_9GEMS <- data.table(read.table("data/DiagnosisGEMs_2015/2015_I10gem.txt", colClasses = c(rep("character", 3))))
  
  hcpcs <- data.table(read.xlsx("data/HCPC2018_CONTR_ANWEB.xlsx"))
  hcpcs$item <- paste(hcpcs$HCPC, ' - ', hcpcs$SHORT.DESCRIPTION)
  
  redbook <- fread("data/redbook/redbook.csv", sep = ",", header= TRUE, colClasses = list(characer=c(1:33)))
  redbook$ROADS <- ifelse(redbook$ROADS == '', 'Unspecified Route', redbook$ROADS)
  
  drg <- fread(file="data/drg34g.csv", sep=",", header=FALSE, colClasses = c("numeric", "character"), col.names = c("DRG", "LABEL"))
  drg$DRG_VALUE <- formatC(drg$DRG, width=3, flag="0")
  drg$DRG_VALUE2 <- substr(drg$DRG_VALUE, 1,2)
  drg$drg_item <- paste(drg$DRG_VALUE, ' - ', drg$LABEL)
 
  icd_meddra <- fread(file="data/icd_to_meddra_version_230.csv", sep="$", header=TRUE)
  
  # Save all datasets to feather format for efficiency!
  datasets <- list(hcpcs = hcpcs, icd10 = icd10, icd10_9GEMS = icd10_9GEMS, icd9 = icd9, 
                   icd9_10GEMS=icd9_10GEMS, redbook=redbook, drg=drg, icd_meddra=icd_meddra)
  names_list <- names(datasets)
  
  for (i in seq_along(datasets)) {
    write_feather(datasets[[i]], path=paste0("data\\", names_list[i], ".feather"))
  }
  rm(datasets, names_list, hcpcs, icd10, icd10_9GEMS, icd9, icd9_10GEMS, redbook, drg, icd_meddra, i)
}
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################

# Read in datasets used for the application
hcpcs <- read_feather(paste0("data/", "hcpcs.feather"))
icd9 <- read_feather(paste0("data/", "icd9.feather"))
icd9_10GEMS <- read_feather(paste0("data/", "icd9_10GEMS.feather"))
icd10 <- read_feather(paste0("data/", "icd10.feather"))
icd10_9GEMS <- read_feather(paste0("data/", "icd10_9GEMS.feather"))
redbook <- read_feather(paste0("data/", "redbook.feather"))
drg <- read_feather(paste0("data/", "drg.feather"))
icd_meddra <- read_feather(paste0("data/", "icd_meddra.feather"))

##################################################################################################################
##################################################################################################################
##################################################################################################################

# Define UI for application
ui <- dashboardPage(
  dashboardHeader(
    title="Merck R&D",
    titleWidth = 350,
    dropdownMenu(type = "messages",
                 messageItem(
                   from = "Mike",
                   message = "Code List Builder is live! Hooray!",
                   icon = icon("trophy"),
                   time = "06-27-2018"
                 ),
                 messageItem(
                   from = "Mike",
                   message = "NDC 'Unspecified Route's added!",
                   icon = icon("exchange"),
                   time = "08-09-2018"
                 ),
                 messageItem(
                   from = "Mike",
                   message = "DRG Codes added!",
                   icon = icon("exchange"),
                   time = "08-15-2018"
                 ),
                 messageItem(
                   from = "Mike",
                   message = "MedDRA to ICD-10 Mapping added!",
                   icon = icon("file-medical"),
                   time = "13-10-2020"
                 )
    )
  ),
  dashboardSidebar(
    width = 350,
    #menuItem("Home", tabName = "home", icon = icon("dashboard")),sidebar <- dashboardSidebar(
    collapsed = TRUE,
    menuItem("Code List Builder", tabName = "codelistbuilder", icon = icon("warehouse")),
    menuItem("About this Tool", tabName = "refs", icon = icon("university"), badgeLabel = "New!", badgeColor = "green")
  ),
  dashboardBody(useShinyjs(),
    tabItems(
      tabItem(tabName = "codelistbuilder", class="active",
              h2("R&D Global Epidemiology Code List Builder"),
              div(id='form',
                # Sidebar with selection options
                box(
                  title='MedDRA Medical Dictionary', solidHeader = TRUE, background='fuchsia', width=4,
                  selectInput('selected_MedDRA_PT', 'Select MedDRA Preferred Terms (PTs)', choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_MedDRA_LLT', 'Select MedDRA Lower Level Terms (LLTs)',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_MedDRA_LLT_COD', 'Select MedDRA Lower Level Codes',  choices=NULL, multiple=TRUE, selectize=TRUE)
                ),
                box(
                  title='ICD-9 Codes for Diagnoses', solidHeader = TRUE, background='light-blue', width=4,
                  selectInput('selected_icd92',  'Select ICD-9 Codes (2-digits)',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd93',  'Select ICD-9 Codes (3-digits)',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd94',  'Select ICD-9 Codes (4-digits)',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd9',  'Select ICD-9 Codes',  choices=NULL, multiple=TRUE, selectize=TRUE)
                ),
                box(
                  title='ICD-10 Codes for Diagnoses', solidHeader = TRUE, background='yellow', width=4,
                  selectInput('selected_icd102', 'Select ICD-10 Codes (2-digits)', choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd103', 'Select ICD-10 Codes (3-digits)', choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd104', 'Select ICD-10 Codes (4-digits)', choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd10', 'Select ICD-10 Codes', choices=NULL, multiple=TRUE, selectize=TRUE)
                ),
                box(
                  title='Diagnostic Related Group', solidHeader = TRUE, background='purple', width=4,
                  selectInput('selected_drg2', 'Select DRG Codes (2-digits)', choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_drg', 'Select DRG Codes',  choices=NULL, multiple=TRUE, selectize=TRUE)
                ),
                box(
                  title='National Drug Code (NDC) Prescription Codes', solidHeader = TRUE, background='red', width=4,
                  selectInput('selected_routes', 'Select NDC Codes by Route (REQUIRED)',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_gennme', 'Select NDC Codes by Generic Name',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_prodnme', 'Select NDC Codes by Brand Name',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_THRCLSD', 'Select NDC Codes by Therapeutic Class',  choices=NULL, multiple=TRUE, selectize=TRUE)
                  #, bookmarkButton()
                ),
                box(
                  title='HCPCS Codes for Injections', solidHeader = TRUE, background='olive', width=4,
                  selectInput('selected_hcpcs', 'Select HCPCS Codes',  choices=NULL, multiple=TRUE, selectize=TRUE)
                )
              ),
              
              # Show a plot of the generated distribution
              fluidRow(title="Current Selections",
                       tabBox(id = 'code_tables', width=12,
                              tabPanel("MedDRA Terms", DT::dataTableOutput("icd_meddra_table")),
                              tabPanel("ICD-9 Diagnosis Codes", DT::dataTableOutput("icd9_table")),
                              tabPanel("ICD-10 Diagnosis Codes", DT::dataTableOutput("icd10_table")),
                              tabPanel("DRG Codes", DT::dataTableOutput("drg_table")),
                              tabPanel("NDC Medication Codes", DT::dataTableOutput("ndc_table"),
                                       hr(),
                                       "List of Distinct Generic Names only:", DT::dataTableOutput("ndc_gentable")),
                              tabPanel("HCPCS Injection Codes", DT::dataTableOutput("hcpcs_table"))
                       )
              ), hr(),
              fluidRow(
                box(status='warning', 
                    textInput('code_group', label="Enter a Label for these Codes (Experimental)", value = "Example Code Group", width = NULL, placeholder = NULL),
                    tags$head(tags$script(src = "message-handler.js")),
                    actionButton("add_label", "Save Codes and Reset Selection")
                ),
                box(title='Click Here to Save Your Results', status='success', downloadButton("downloadData", "Download"))
              )
      ),
      tabItem(tabName = "refs",
              h2("R&D Global Epidemiology Code List Builder Information"),
              h3("Data Sources"),
              p("The content of this tool come from multiple sources. ICD-9, ICD-10, HCPCS, and DRG codes are all sourced from the US Centers for Medicaid Services website cms.gov"),
              p("The MedDRA codes were developed in-house by the Medical Coding Group (contact Kerstin Kuehn for more information)."),
              p("NDC codes used in this tool come from the IBM Marketscan Redbook tables."),
              h3("Internal Data Linkages"),
              p("In this tool, automatic linkage between MedDRA, ICD-9, and ICD-10 are made by the mapping file from Medical Coding and the ICD-9<->ICD-10 GEMs linkages found on cms.gov.")
      )
    )
  )
)

##################################################################################################################
##################################################################################################################
##################################################################################################################
# Define server logic
server <- function(input, output, session) {
  
  # Server side selectize updating
  updateSelectizeInput(session, 'selected_icd92',   choices = icd9$item2,   server = TRUE)
  updateSelectizeInput(session, 'selected_icd93',   choices = icd9$item3,   server = TRUE)
  updateSelectizeInput(session, 'selected_icd94',   choices = icd9$item4,   server = TRUE)
  updateSelectizeInput(session, 'selected_icd9',    choices = icd9$item,    server = TRUE)
  
  updateSelectizeInput(session, 'selected_icd102',  choices = icd10$item2,  server = TRUE)
  updateSelectizeInput(session, 'selected_icd103',  choices = icd10$item3,  server = TRUE)
  updateSelectizeInput(session, 'selected_icd104',  choices = icd10$item4,  server = TRUE)
  updateSelectizeInput(session, 'selected_icd10',   choices = icd10$item,   server = TRUE)
  
  updateSelectizeInput(session, 'selected_hcpcs',   choices = hcpcs$item,      server = TRUE)
  updateSelectizeInput(session, 'selected_gennme',  choices = redbook$GENNME,  server = TRUE)
  updateSelectizeInput(session, 'selected_prodnme', choices = redbook$PRODNME, server = TRUE)
  updateSelectizeInput(session, 'selected_THRCLSD', choices = redbook$THRCLDS, server = TRUE)
  updateSelectizeInput(session, 'selected_routes',  choices = redbook$ROADS,   server = TRUE)
  
  updateSelectizeInput(session, 'selected_drg',     choices = drg$drg_item,    server = TRUE)
  updateSelectizeInput(session, 'selected_drg2',    choices = drg$DRG_VALUE2,  server = TRUE)
  
  updateSelectizeInput(session, 'selected_MedDRA_PT',     choices = icd_meddra$PT_NAM,   server = TRUE)
  updateSelectizeInput(session, 'selected_MedDRA_LLT',    choices = icd_meddra$LLT_NAM,  server = TRUE)
  updateSelectizeInput(session, 'selected_MedDRA_LLT_COD',choices = icd_meddra$LLT_COD,  server = TRUE)
  
  # Render coding tables for display of selected codes
  output$icd9_table <- DT::renderDataTable({
    DT::datatable(icd9[(icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93 | 
                          icd9$item4 %chin% input$selected_icd94 | icd9$item %chin% input$selected_icd9 | 
                          icd9$DIAGNOSIS.CODE %chin% icd10_9GEMS[icd10_9GEMS$V1 %chin% 
                                                                   icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                            icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                            icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2 |
                                                                            icd10$VALUE %chin% icd_meddra[(icd_meddra$PT_NAM %chin% input$selected_MedDRA_PT | 
                                                                                                             icd_meddra$LLT_NAM %chin% input$selected_MedDRA_LLT | 
                                                                                                             icd_meddra$LLT_COD %in% input$selected_MedDRA_LLT_COD  |
                                                                                                             icd_meddra$CODE %chin% icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                                                                                             icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                                                                                             icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2),]$VALUE),]$CODE
                                                                   ), ]$VALUE, ]$V2
                        ), c(1,2), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$icd10_table <- DT::renderDataTable({
    DT::datatable(icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                           icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                           icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2 |
                           icd10$VALUE %chin% icd_meddra[(icd_meddra$PT_NAM %chin% input$selected_MedDRA_PT | 
                                      icd_meddra$LLT_NAM %chin% input$selected_MedDRA_LLT | 
                                      icd_meddra$LLT_COD %in% input$selected_MedDRA_LLT_COD  |
                                      icd_meddra$CODE %chin% icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                      icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                      icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2),]$VALUE),]$CODE
                        ), c(1,2,4,5), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$icd_meddra_table <- DT::renderDataTable({
    DT::datatable(icd_meddra[(icd_meddra$PT_NAM %chin% input$selected_MedDRA_PT | 
                                icd_meddra$LLT_NAM %chin% input$selected_MedDRA_LLT | 
                                icd_meddra$LLT_COD %in% input$selected_MedDRA_LLT_COD  |
                                icd_meddra$CODE %chin% icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2),]$VALUE
                           ), c(5,6,7,8), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$hcpcs_table <- DT::renderDataTable({
    DT::datatable(hcpcs[hcpcs$item %chin% input$selected_hcpcs, c(1,5,4), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$drg_table <- DT::renderDataTable({
    DT::datatable(drg[(drg$drg_item %chin% input$selected_drg | drg$DRG_VALUE2 %chin% input$selected_drg2), c(3,2), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$ndc_table <- DT::renderDataTable({
    DT::datatable(redbook[((redbook$GENNME %chin% input$selected_gennme | redbook$PRODNME %chin% input$selected_prodnme | redbook$THRCLDS %chin% input$selected_THRCLSD) & (redbook$ROADS %chin% input$selected_routes)), c(1,32,30), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$ndc_gentable <- DT::renderDataTable({
    ndcdf <- redbook[((redbook$GENNME %chin% input$selected_gennme | redbook$PRODNME %chin% input$selected_prodnme | redbook$THRCLDS %chin% input$selected_THRCLSD) & (redbook$ROADS %chin% input$selected_routes)), c(32), drop=FALSE]
    DT::datatable(unique(ndcdf), options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  
  
  # Add code labels here
  observeEvent(input$add_label, {
    ifelse(exists('i'), i <<- i + 1, i <- 1)
    hcpcs_data <- hcpcs[hcpcs$item %chin% input$selected_hcpcs, c(1:48), drop=FALSE]
    
    drg_data <- drg[(drg$drg_item %chin% input$selected_drg | drg$DRG_VALUE2 %chin% input$selected_drg2), c(3,2), drop=FALSE]
    
    icd9_data  <- icd9[(icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93 | 
                          icd9$item4 %chin% input$selected_icd94 | icd9$item %chin% input$selected_icd9 | 
                          icd9$DIAGNOSIS.CODE %chin% icd10_9GEMS[icd10_9GEMS$V1 %chin% 
                                                                   icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                            icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                            icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2 |
                                                                            icd10$VALUE %chin% icd_meddra[(icd_meddra$PT_NAM %chin% input$selected_MedDRA_PT | 
                                                                                                             icd_meddra$LLT_NAM %chin% input$selected_MedDRA_LLT | 
                                                                                                             icd_meddra$LLT_COD %in% input$selected_MedDRA_LLT_COD  |
                                                                                                             icd_meddra$CODE %chin% icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                                                                                             icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                                                                                             icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2),]$VALUE),]$CODE
                                                                   ), ]$VALUE, ]$V2
    ), c(1,2), drop=FALSE]
    
    icd10_data  <- icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                            icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                            icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2 |
                            icd10$VALUE %chin% icd_meddra[(icd_meddra$PT_NAM %chin% input$selected_MedDRA_PT | 
                                                             icd_meddra$LLT_NAM %chin% input$selected_MedDRA_LLT | 
                                                             icd_meddra$LLT_COD %in% input$selected_MedDRA_LLT_COD  |
                                                             icd_meddra$CODE %chin% icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                                             icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                                             icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2),]$VALUE),]$CODE
    ), c(1,2,4,5), drop=FALSE]
    
    ndc_data <- redbook[((redbook$GENNME %chin% input$selected_gennme | redbook$PRODNME %chin% input$selected_prodnme | redbook$THRCLDS %chin% input$selected_THRCLSD) & (redbook$ROADS %chin% input$selected_routes)
    ), c(1,32,30, c(2:29), 33), drop=FALSE]
    
    icd_meddra_data <-icd_meddra[(icd_meddra$PT_NAM %chin% input$selected_MedDRA_PT | 
                                    icd_meddra$LLT_NAM %chin% input$selected_MedDRA_LLT | 
                                    icd_meddra$LLT_COD %in% input$selected_MedDRA_LLT_COD  |
                                    icd_meddra$CODE %chin% icd10[(icd10$item2%chin% input$selected_icd102 | icd10$item3 %chin% input$selected_icd103 | 
                                                                    icd10$item4 %chin% input$selected_icd104 | icd10$item %chin% input$selected_icd10 | 
                                                                    icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item2 %chin% input$selected_icd92 | icd9$item3 %chin% input$selected_icd93| icd9$item4 %chin% input$selected_icd94), ]$DIAGNOSIS.CODE, ]$V2),]$VALUE
    ), c(5,6,7,8), drop=FALSE]
    
    if(exists("icd9_data")){
      icd9_data$code_group <- input$code_group
      icd9_data$code_group_n <- i
      }
    if(exists("icd10_data")){
      icd10_data$code_group <- input$code_group
      icd10_data$code_group_n <- i
      }
    if(exists("icd_meddra_data")){
      icd_meddra_data$code_group <- input$code_group
      icd_meddra_data$code_group_n <- i
      }
    if(exists("drg_data")){
      drg_data$code_group <- input$code_group
      drg_data$code_group_n <- i
      }
    if(exists("ndc_data")){
      ndc_data$code_group <- input$code_group
      ndc_data$code_group_n <- i
      }
    if(exists("hcpcs_data")){
      hcpcs_data$code_group <- input$code_group
      hcpcs_data$code_group_n <- i
      }
    
    ifelse(exists("df_a"), df_a <- rbind(df_a, icd_meddra_data), df_a <- icd_meddra_data)
    ifelse(exists("df_b"), df_b <- rbind(df_b, icd9_data      ), df_b <- icd9_data)
    ifelse(exists("df_c"), df_c <- rbind(df_c, icd10_data     ), df_c <- icd10_data)
    ifelse(exists("df_d"), df_d <- rbind(df_d, drg_data       ), df_d <- drg_data)
    ifelse(exists("df_e"), df_e <- rbind(df_e, ndc_data       ), df_e <- ndc_data)
    ifelse(exists("df_f"), df_f <- rbind(df_f, hcpcs_data     ), df_f <- hcpcs_data)
    
    reset("form")
    
    session$sendCustomMessage(type = 'testmessage',
                              message = 'Code Group has been Added to Selections')
  })
  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    
    # Shiny saving functions
    filename = function() {
      paste("codelist_", Sys.Date(), ".xlsx", sep = "")
    },
    content = function(file) {
      
      # Organized workbook format
      if(exists("df_a") | exists("df_b") | exists("df_c") | exists("df_d") | exists("df_e") | exists("df_f")){
        wb <- createWorkbook()
        if(exists("df_a")){
          addWorksheet(wb = wb, sheetName = "MedDRA", gridLines = TRUE)
          writeDataTable(wb = wb, sheet = "MedDRA", x = df_a, rowNames=TRUE)
        }
        if(exists("df_b")){
          addWorksheet(wb = wb, sheetName = "ICD9", gridLines = TRUE)
          writeDataTable(wb = wb, sheet = "ICD9", x = df_b, rowNames=TRUE)
        }
        if(exists("df_c")){
          addWorksheet(wb = wb, sheetName = "ICD10", gridLines = TRUE)
          writeDataTable(wb = wb, sheet = "ICD10", x = df_c, rowNames=TRUE)
        }
        if(exists("df_d")){
          addWorksheet(wb = wb, sheetName = "DRG", gridLines = TRUE)
          writeDataTable(wb = wb, sheet = "DRG", x = df_d, rowNames=TRUE)
        }
        if(exists("df_e")){
          addWorksheet(wb = wb, sheetName = "NDC", gridLines = TRUE)
          writeDataTable(wb = wb, sheet = "NDC", x = df_e, rowNames=TRUE)
        }
        if(exists("df_f")){
          addWorksheet(wb = wb, sheetName = "HCPCS", gridLines = TRUE)
          writeDataTable(wb = wb, sheet = "HCPCS", x = df_f, rowNames=TRUE)
        }
        saveWorkbook(wb, file, overwrite = TRUE)
      }
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)