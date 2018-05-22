#install.packages(c("shinydashboard", "shiny","openxlsx","data.table","DT"))

library(shiny)
library(shinydashboard)
library(openxlsx)
library(data.table)
library(DT)

# Set zip environment variable to save out the xlsx files
#Sys.setenv(R_ZIPCMD= "\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\bin\\zip.exe")

# Mike's testing environment
#icd9 <- data.table(read.xlsx("\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\data\\ICD-9-CM-v32-master-descriptions\\CMS32_DESC_LONG_SHORT_DX.xlsx"))
#icd9$item <- paste(icd9$DIAGNOSIS.CODE, ' - ', icd9$SHORT.DESCRIPTION)
#icd9$item3 <- substr(icd9$DIAGNOSIS.CODE,1,3)

#icd10 <- data.table(read.xlsx("\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\data\\2015-code-descriptions\\icd10cm_order_2015_excelformat.xlsx"))
#icd10$VALUE <- trimws(icd10$VALUE, which = "right")
#icd10$item <- paste(icd10$VALUE, ' - ', icd10$SHORT.DESCRIPTION)
#icd10$item3 <- substr(icd10$VALUE,1,3)

#icd9_10GEMS <- data.table(read.table("\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\data\\DiagnosisGEMs_2015\\2015_I9gem.txt", colClasses = c(rep("character", 3))))
#icd10_9GEMS <- data.table(read.table("\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\data\\DiagnosisGEMs_2015\\2015_I10gem.txt", colClasses = c(rep("character", 3))))

#hcpcs <- data.table(read.xlsx("\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\data\\HCPC2018_CONTR_ANWEB.xlsx"))
#hcpcs$item <- paste(hcpcs$HCPC, ' - ', hcpcs$SHORT.DESCRIPTION)

#redbook <- fread("\\\\Deda1nadat01\\PHAKLINIK\\Epidemiology\\Projects\\2_Non Product-related Projects\\HIF\\Tools & Resources\\Code List Builder\\data\\redbook\\redbook.csv", sep = ",", header= TRUE, colClasses = list(characer=c(1:33)))

##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################

icd9 <- data.table(read.xlsx('data/ICD-9-CM-v32-master-descriptions/CMS32_DESC_LONG_SHORT_DX.xlsx'))
icd9$item <- paste(icd9$DIAGNOSIS.CODE, ' - ', icd9$SHORT.DESCRIPTION)
icd9$item3 <- substr(icd9$DIAGNOSIS.CODE,1,3)

icd10 <- data.table(read.xlsx("data/2015-code-descriptions/icd10cm_order_2015_excelformat.xlsx"))
icd10$VALUE <- trimws(icd10$VALUE, which = "right")
icd10$item <- paste(icd10$VALUE, ' - ', icd10$SHORT.DESCRIPTION)
icd10$item3 <- substr(icd10$VALUE,1,3)

icd9_10GEMS <- data.table(read.table("data/DiagnosisGEMs_2015/2015_I9gem.txt", colClasses = c(rep("character", 3))))
icd10_9GEMS <- data.table(read.table("data/DiagnosisGEMs_2015/2015_I10gem.txt", colClasses = c(rep("character", 3))))

hcpcs <- data.table(read.xlsx("data/HCPC2018_CONTR_ANWEB.xlsx"))
hcpcs$item <- paste(hcpcs$HCPC, ' - ', hcpcs$SHORT.DESCRIPTION)

redbook <- fread("data/redbook/redbook.csv", sep = ",", header= TRUE, colClasses = list(characer=c(1:33)))

##################################################################################################################
##################################################################################################################
##################################################################################################################

# Define UI for application
ui <- dashboardPage(
  dashboardHeader(
    title="Merck R&D",
    titleWidth = 350
  ),
  dashboardSidebar(
    width = 350,
    #menuItem("Home", tabName = "home", icon = icon("dashboard")),
    menuItem("Code List Builder", tabName = "codelistbuilder", icon = icon("th"))
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "home",
              h2("Home tab content")
      ),
      tabItem(tabName = "codelistbuilder",
            h2("R&D Global Epidemiology Code List Builder"),
            fluidRow(
              # Sidebar with selection options
                box(
                  title='ICD Codes for Diagnoses', solidHeader = TRUE, background='light-blue', width=4,
                  selectInput('selected_icd93',  'Select ICD-9 Codes (3-digits)',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd9',  'Select ICD-9 Codes',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd103', 'Select ICD-10 Codes (3-digits)', choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_icd10', 'Select ICD-10 Codes', choices=NULL, multiple=TRUE, selectize=TRUE)
                ),
                box(
                  title='HCPCS Codes for Injections', solidHeader = TRUE, background='olive', width=4,
                  selectInput('selected_hcpcs', 'Select HCPCS Codes',  choices=NULL, multiple=TRUE, selectize=TRUE)
                  ),
                box(
                  title='National Drug Code (NDC) Prescription Codes', solidHeader = TRUE, background='red', width=4,
                  selectInput('selected_gennme', 'Select NDC Codes by Generic Name',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_prodnme', 'Select NDC Codes by Brand Name',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_THRCLSD', 'Select NDC Codes by Therapeutic Class',  choices=NULL, multiple=TRUE, selectize=TRUE),
                  selectInput('selected_routes', 'Select NDC Codes by Route (required)',  choices=NULL, multiple=TRUE, selectize=TRUE)
                  #, bookmarkButton()
                )
              ),

              # Show a plot of the generated distribution
              fluidRow(title="Current Selections",
                        tabBox(id = 'code_tables', width=12,
                          tabPanel("ICD-9 Diagnosis Codes", DT::dataTableOutput("icd9_table")),
                          tabPanel("ICD-10 Diagnosis Codes", DT::dataTableOutput("icd10_table")),
                          tabPanel("HCPCS Injection Codes", DT::dataTableOutput("hcpcs_table")),
                          tabPanel("NDC Medication Codes", DT::dataTableOutput("ndc_table"),
                                   hr(),
                                   "List of Distinct Generic Names only:", DT::dataTableOutput("ndc_gentable"))
                        )
              ),
              fluidRow(
                box(title='Click Here to Save Your Results', status='success', downloadButton("downloadData", "Download"))
              )
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
  updateSelectizeInput(session, 'selected_icd93',  choices = icd9$item3,   server = TRUE)
  updateSelectizeInput(session, 'selected_icd9',   choices = icd9$item,    server = TRUE)
  updateSelectizeInput(session, 'selected_icd103', choices = icd10$item3,  server = TRUE)
  updateSelectizeInput(session, 'selected_icd10',  choices = icd10$item,   server = TRUE)
  updateSelectizeInput(session, 'selected_hcpcs',  choices = hcpcs$item,   server = TRUE)
  updateSelectizeInput(session, 'selected_gennme', choices = redbook$GENNME, server = TRUE)
  updateSelectizeInput(session, 'selected_prodnme', choices = redbook$PRODNME, server = TRUE)
  updateSelectizeInput(session, 'selected_THRCLSD', choices = redbook$THRCLDS, server = TRUE)
  updateSelectizeInput(session, 'selected_routes', choices = redbook$ROADS, server = TRUE)

  #callModule(module=regexSelect, id='selected_icd9', reactive(icd9$item))

  # Render coding tables for display of selected codes
  output$icd9_table <- DT::renderDataTable({
    DT::datatable(icd9[(icd9$item3 %chin% input$selected_icd93 | icd9$item %chin% input$selected_icd9 | icd9$DIAGNOSIS.CODE %chin% icd10_9GEMS[icd10_9GEMS$V1 %chin% icd10[(icd10$item %chin% input$selected_icd10 | icd10$item3 %chin% input$selected_icd103), ]$VALUE, ]$V2)
                       , c(1,2), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$icd10_table <- DT::renderDataTable({
    DT::datatable(icd10[(icd10$item3 %chin% input$selected_icd103 | icd10$item %chin% input$selected_icd10 | icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item3 %chin% input$selected_icd93), ]$DIAGNOSIS.CODE, ]$V2)
                        , c(1,2,4,5), drop=FALSE]
                  , options = list(lengthMenu = c(5, 30, 50), pageLength = 5), rownames= FALSE)
  })
  output$hcpcs_table <- DT::renderDataTable({
    DT::datatable(hcpcs[hcpcs$item %chin% input$selected_hcpcs, c(1,5,4), drop=FALSE]
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

  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(

    # Shiny saving functions
    filename = function() {
      paste("codelist_", Sys.Date(), ".xlsx", sep = "")
    },
    content = function(file) {
      # Data to be saved
      hcpcs_data <- hcpcs[hcpcs$item %chin% input$selected_hcpcs, c(1:48), drop=FALSE]
      icd9_data  <- icd9[(icd9$item3 %chin% input$selected_icd93 | icd9$item %chin% input$selected_icd9 | icd9$DIAGNOSIS.CODE %chin% icd10_9GEMS[icd10_9GEMS$V1 %chin% icd10[(icd10$item %chin% input$selected_icd10 | icd10$item3 %chin% input$selected_icd103), ]$VALUE, ]$V2)
                         , c(1,2), drop=FALSE]
      icd10_data  <- icd10[(icd10$item3 %chin% input$selected_icd103 | icd10$item %chin% input$selected_icd10 | icd10$VALUE %chin% icd9_10GEMS[icd9_10GEMS$V1 %chin% icd9[(icd9$item %chin% input$selected_icd9 | icd9$item3 %chin% input$selected_icd93), ]$DIAGNOSIS.CODE, ]$V2)
                           , c(1,2,4,5), drop=FALSE]
      ndc_data <- redbook[((redbook$GENNME %chin% input$selected_gennme | redbook$PRODNME %chin% input$selected_prodnme | redbook$THRCLDS %chin% input$selected_THRCLSD) & (redbook$ROADS %chin% input$selected_routes)),
                          c(1,32,30, c(2:29), 33), drop=FALSE]
      # Organized workbook format
      wb <- createWorkbook()
      addWorksheet(wb = wb, sheetName = "ICD9", gridLines = TRUE)
      writeDataTable(wb = wb, sheet = "ICD9", x = icd9_data, rowNames=TRUE)
      addWorksheet(wb = wb, sheetName = "ICD10", gridLines = TRUE)
      writeDataTable(wb = wb, sheet = "ICD10", x = icd10_data, rowNames=TRUE)
      addWorksheet(wb = wb, sheetName = "HCPCS", gridLines = TRUE)
      writeDataTable(wb = wb, sheet = "HCPCS", x = hcpcs_data, rowNames=TRUE)
      addWorksheet(wb = wb, sheetName = "NDC", gridLines = TRUE)
      writeDataTable(wb = wb, sheet = "NDC", x = ndc_data, rowNames=TRUE)
      saveWorkbook(wb, file, overwrite = TRUE)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)