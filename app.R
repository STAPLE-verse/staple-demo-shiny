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
project_data <<- read.csv("data/project_data.csv")
task_data <<- read.csv("data/tasks_data.csv")

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
      # write.csv(orcid_data, "data/users_orc.csv", row.names = F)
      
      show_alert(
        title = "User Added",
        text = "rorcid no longer works, so this demo does not create new users.",
        type = "success"
      )
      
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
  
  # add projects fake note ----
  observeEvent(input$save_new_project, {
    # write.csv(project_data, "data/project_data.csv", row.names = F)
    show_alert(
      title = "Demo",
      text = "This demo does not create new projects.",
      type = "warning"
    )
  })
  
  # spam tables ----
  output$spam_project_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "spaml") %>% 
                filter(box == "project"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$spam_ethics_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "spaml") %>% 
                filter(box == "ethics"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$spam_materials_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "spaml") %>% 
                filter(box == "materials"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$spam_prereg_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "spaml") %>% 
                filter(box == "prereg"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$spam_analyses_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "spaml") %>% 
                filter(box == "analyses"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$spam_manuscript_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "spaml") %>% 
                filter(box == "manuscript"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$spam_task_table <- renderDT(server = FALSE, {
    
    datatable(task_data %>% 
                filter(tab == "spaml"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  observeEvent(input$save_spaml, {
    # write.csv(project_data, "data/project_data.csv", row.names = F)
    show_alert(
      title = "Success",
      text = "SPAML Data Saved\n (data does not save in demo)",
      type = "success"
    )
  })
  
  # tod tables ----
   
  output$tod_project_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "tod") %>% 
                filter(box == "project"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$tod_materials_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "tod") %>% 
                filter(box == "materials"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$tod_analyses_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "tod") %>% 
                filter(box == "analyses"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$tod_manuscript_table <- renderDT(server = FALSE, {
    
    datatable(project_data %>% 
                filter(tab == "tod") %>% 
                filter(box == "manuscript"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  output$tod_task_table <- renderDT(server = FALSE, {
    
    datatable(task_data %>% 
                filter(tab == "tod"),
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  observeEvent(input$save_tod, {
    # write.csv(project_data, "data/project_data.csv", row.names = F)
    show_alert(
      title = "Success",
      text = "Table of Doom Data Saved\n (data does not save in demo)",
      type = "success"
    )
  })

  # task information ----
  observeEvent(input$save_new_task, {
    task_data <<- bind_rows(
      task_data,
      data.frame(tab = input$add_project_task, 
                 person = input$add_user_task, 
                 Task = input$add_info_task)
    )
    
    write.csv(task_data, "data/tasks_data.csv", row.names = F)
    show_alert(
      title = "Success",
      text = "New Task Added",
      type = "success"
    )
  })
  
  output$current_task_table <- renderDT(server = FALSE, {
    
    datatable(task_data,
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = TRUE)
  })
  
  observeEvent(input$current_task_table_cell_edit, {
    row  <- input$current_task_table_cell_edit$row
    clmn <- input$current_task_table_cell_edit$col+1
    task_data[row, clmn] <<- input$current_task_table_cell_edit$value
  })
  
  observeEvent(input$edit_tasks, {

    write.csv(task_data, "data/tasks_data.csv", row.names = F)
    show_alert(
      title = "Success",
      text = "Tasks Edited",
      type = "success"
    )
  })
  
  # credit information ----
  output$spam_credit_table <- renderDT(server = FALSE, {
    
    temp <- project_data %>% 
      filter(tab == "spaml") %>% 
      left_join(
        orcid_data, by = c("Creator" = "ORCID")
      )
    
    datatable(temp,
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = FALSE)
  })
  
  output$tod_credit_table <- renderDT(server = FALSE, {
    
    temp <- project_data %>% 
      filter(tab == "tod") %>% 
      left_join(
        orcid_data, by = c("Creator" = "ORCID")
      )
    
    datatable(temp,
              extensions = 'Buttons',
              options = list(lengthChange = TRUE,
                             scrollX = TRUE, 
                             dom = 'ftBp',
                             buttons = c('copy', 'csv', 'excel')),
              rownames = FALSE,
              editable = FALSE)
  })
  
  observeEvent(input$spaml_credit_ten, {
    
    show_alert(
      title = "Success",
      text = "Download tenzing table (demo does not create table)",
      type = "success"
    )
  })
  
  observeEvent(input$spaml_yaml, {
    
    show_alert(
      title = "Success",
      text = "Download yaml (demo does not create yaml)",
      type = "success"
    )
  })
  
  observeEvent(input$tod_credit_ten, {
    
    show_alert(
      title = "Success",
      text = "Download tenzing table (demo does not create table)",
      type = "success"
    )
  })
  
  observeEvent(input$tod_yaml, {
    
    show_alert(
      title = "Success",
      text = "Download yaml (demo does not create yaml)",
      type = "success"
    )
  })
  
  
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
