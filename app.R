#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Libraries
library(shiny)
library(bs4Dash)
library(rorcid)
library(dplyr)
library(purrr)
library(DT)
library(shinyWidgets)

# Data
orcid_data <<- read.csv("data/users_orc.csv")

# Source
source("toolbars.R")

# Define UI for application that draws a histogram
ui <- dashboardPage(
  title = "STAPLE",
  header = top_nav,
  sidebar = left_nav,
  controlbar = NULL,
  footer = bottom_nav,
  body = body_nav,
  freshTheme = NULL,
  preloader = NULL,
  options = NULL,
  fullscreen = FALSE,
  help = FALSE,
  dark = FALSE,
  scrollToTop = FALSE
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # view current users ----
  output$orcid_table <- renderDT(server = FALSE, {
    
    datatable(orcid_data,
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  # user edit save button ----
  observeEvent(input$orcid_table_cell_edit, {
    row  <- input$orcid_table_cell_edit$row
    clmn <- input$orcid_table_cell_edit$col+1
    orcid_data[row, clmn] <<- input$orcid_table_cell_edit$value
  })
  
  observeEvent(input$user_save_button, {
    write.csv(orcid_data, "data/users_orc.csv", row.names = F)
    show_alert(
      title = "Success",
      text = "User Data Saved",
      type = "success"
    )
  })
  
  # add new user ----
  observeEvent(input$user_add_button, {
    orcid_to_get <- gsub("http|https|orcid|\\.|org", "", input$add_orcid)
    if (nchar(orcid_to_get) == 19){
      # get the new person
      # orcid_person <- rorcid::orcid_person(orcid_to_get)  
      # orcid_temp <- orcid_person %>% {
      #   dplyr::tibble(
      #     created_date = purrr::map_dbl(., purrr::pluck, "name", "created-date", "value", .default=NA_integer_),
      #     given_name = purrr::map_chr(., purrr::pluck, "name", "given-names", "value", .default=NA_character_),
      #     family_name = purrr::map_chr(., purrr::pluck, "name", "family-name", "value", .default=NA_character_),
      #     credit_name = purrr::map_chr(., purrr::pluck, "name", "credit-name", "value", .default=NA_character_),
      #     # other_names = purrr::map(., purrr::pluck, "other-names", "other-name", "content", .default=NA_character_),
      #     orcid_identifier_path = purrr::map_chr(., purrr::pluck, "name", "path", .default = NA_character_),
      #     # biography = purrr::map_chr(., purrr::pluck, "biography", "content", .default=NA_character_),
      #     # researcher_urls = purrr::map(., purrr::pluck, "researcher-urls", "researcher-url", .default=NA_character_),
      #     # emails = purrr::map(., purrr::pluck, "emails", "email", "email", .default=NA_character_)
      #     # keywords = purrr::map(., purrr::pluck, "keywords", "keyword", "content", .default=NA_character_)
      #     #external_ids = purrr::map(., purrr::pluck, "external-identifiers", "external-identifier", .default=NA_character_)
      #   )
      # }
      # 
      # # add in the old data 
      # orcid_data <<- bind_rows(
      #   orcid_data,
      #   orcid_temp
      # )
      
      # save the data
      write.csv(orcid_data, "data/users_orc.csv", row.names = F)
      
      # show the new table
      output$orcid_table_update <- renderDT(server = FALSE, {
        
        datatable(orcid_data,
                  extensions = 'Buttons',
                  options = list(lengthChange = TRUE,
                                 scrollX = TRUE, 
                                 dom = 'ftBp',
                                 buttons = c('copy', 'csv', 'excel')),
                  rownames = FALSE)
      })
      
    } else {
      show_alert(
        title = "Error",
        text = "Oops! ORCID Not Right",
        type = "warning"
      )
    }
    
  })
  
  # more functions ----
  

  
}

# Run the application 
shinyApp(ui = ui, server = server)
