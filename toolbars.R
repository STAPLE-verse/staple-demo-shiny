
# sidebar -----------------------------------------------------------------

left_nav <- 
  dashboardSidebar(
    # add person customization
    sidebarUserPanel(
      image = img(src="staple.png"),
      name = "Hi User!"
    ), 
    
    # add menu
    sidebarMenu(
      id = "left_sidebarmenu",
      menuItem(
        "Users",
        tabName = "item1",
        icon = icon("user")
      ),
      menuItem(
        "Projects",
        tabName = "item2",
        icon = icon("bars-progress")
      ),
      menuItem(
        "Tasks",
        tabName = "item3",
        icon = icon("list-check")
      )
    ),
    
    # side bar rules 
    disable = FALSE,
    width = NULL,
    skin = "light",
    status = "primary",
    elevation = 4,
    collapsed = TRUE,
    minified = FALSE,
    expandOnHover = TRUE,
    fixed = TRUE,
    id = "left_sidebar",
    customArea = NULL
)

# top nav -----------------------------------------------------------------

top_nav <- 
  dashboardHeader(
    title = "STAPLE",
    titleWidth = NULL,
    disable = FALSE,
    .list = NULL,
    skin = "light",
    status = "white",
    border = TRUE,
    compact = FALSE,
    sidebarIcon = shiny::icon("bars"),
    controlbarIcon = shiny::icon("th"),
    fixed = FALSE,
    leftUi = NULL,
    rightUi = NULL
  )


# right nav ---------------------------------------------------------------

right_nav <- 
  dashboardControlbar(
    id = NULL,
    disable = FALSE,
    width = 250,
    collapsed = TRUE,
    overlay = TRUE,
    skin = "dark",
    pinned = NULL
  )

# bottom nav --------------------------------------------------------------

bottom_nav <- dashboardFooter(
  left = a(
    href = "https://aggieerin.com",
    target = "_blank", "@aggieerin"
  ),
  right = "STAPLE Demo 2023"
)

# body nav ----------------------------------------------------------------

body_nav <- 
  dashboardBody(
    tabItems(
      # tab for people ----
      tabItem(
        tabName = "item1",
        fluidRow(
          tabBox(
            title = tags$b("Add and Edit Collaborators"),
            #collapsible = TRUE,
            #solidHeader = TRUE,
            #status = "primary",
            width = 12, 
            id = "user_box", 
            tabPanel("Add User",
                     textInput(inputId = "add_orcid", 
                               label = "ORCID of User", 
                               value = "", 
                               width = NULL, 
                               placeholder = NULL),
                     actionBttn("user_add_button", 
                                label = "Add New User", 
                                style = "material-flat",
                                size = "sm", 
                                color = "primary"),
                     DTOutput("orcid_table_update")
            ),
            tabPanel("Edit User", 
                     DTOutput("orcid_table"), 
                     actionBttn("user_save_button", 
                                label = "Save User Edits", 
                                style = "material-flat",
                                size = "sm", 
                                color = "primary")
                     ) #tab panel 
            ) # box
          ) #fluidrow
      ), #tabItem
      
      # tab for projects ----
      tabItem(
        tabName = "item2", 
        fluidRow(
          tabBox(
            title = tags$b("Add and Edit Projects"),
            #collapsible = TRUE,
            #solidHeader = TRUE,
            #status = "primary",
            width = 12, 
            id = "project_box",
            # add project ----
            tabPanel("Add Project",
                     textInput(
                       inputId = "add_project_title",
                       label = "Project Title"
                     ),
                     selectInput(
                       inputId = "add_project_template",
                       label = "Project Template",
                       choices = c("Experiment", 
                                   "Meta-Analysis", 
                                   "Qualitative",
                                   "Biological",
                                   "Simulation"),
                       selected = NULL,
                       multiple = FALSE,
                       selectize = TRUE
                     ),
                     actionBttn("save_new_project", 
                                label = "Create New Project", 
                                style = "material-flat",
                                size = "sm", 
                                color = "primary")
            ),
            # spaml ----
            tabPanel("SPAML", 
                     # put cards here 
                     sortable(
                       width = 12, 
                       box(
                         title = "Project Metadata",
                         width = 12,
                         DTOutput("spam_project_table"), 
                         id = "spam1"
                       ), 
                       box(
                         title = "Ethics",
                         width = 12,
                         DTOutput("spam_ethics_table"), 
                         id = "spam2"
                       ), 
                       box(
                         title = "Materials",
                         width = 12,
                         DTOutput("spam_materials_table"), 
                         id = "spam3"
                       ),
                       box(
                         title = "Pre-Registration",
                         width = 12,
                         DTOutput("spam_prereg_table"), 
                         id = "spam4"
                       ),
                       box(
                         title = "Analyses",
                         width = 12,
                         DTOutput("spam_analyses_table"), 
                         id = "spam5"
                       ),
                       box(
                         title = "Manuscript",
                         width = 12,
                         DTOutput("spam_manuscript_table"), 
                         id = "spam6"
                       ),
                       box(
                         title = "CRediT",
                         width = 12,
                         DTOutput("spam_credit_table"), 
                         id = "spam7",
                         actionBttn("spaml_credit_ten", 
                                    label = "Create tenzing", 
                                    style = "material-flat",
                                    size = "sm", 
                                    color = "primary"),
                         actionBttn("spaml_yaml", 
                                    label = "Create yaml", 
                                    style = "material-flat",
                                    size = "sm", 
                                    color = "primary")
                       ),
                       box(
                         title = "Tasks",
                         width = 12,
                         DTOutput("spam_task_table"), 
                         id = "spam8"
                       )
                     ),
                     actionBttn("save_spaml", 
                                label = "Save Project Data", 
                                style = "material-flat",
                                size = "sm", 
                                color = "primary")
                     ), # close tabpanel
            # TOD ----
            tabPanel("Table of Doom",
                     sortable(
                       width = 12, 
                       box(
                         title = "Project Metadata",
                         width = 12,
                         DTOutput("tod_project_table"), 
                         id = "tod1"
                       ), 
                       box(
                         title = "Materials",
                         width = 12,
                         DTOutput("tod_materials_table"), 
                         id = "tod2"
                       ),
                       box(
                         title = "Analyses",
                         width = 12,
                         DTOutput("tod_analyses_table"), 
                         id = "tod3"
                       ),
                       box(
                         title = "Manuscript",
                         width = 12,
                         DTOutput("tod_manuscript_table"), 
                         id = "tod4"
                       ),
                       box(
                         title = "CRediT",
                         width = 12,
                         DTOutput("tod_credit_table"),
                         actionBttn("tod_credit_ten", 
                                    label = "Create tenzing", 
                                    style = "material-flat",
                                    size = "sm", 
                                    color = "primary"),
                         actionBttn("tod_yaml", 
                                    label = "Create yaml", 
                                    style = "material-flat",
                                    size = "sm", 
                                    color = "primary"),
                         id = "tod5"
                       ),
                       box(
                         title = "Tasks",
                         width = 12,
                         DTOutput("tod_task_table"), 
                         id = "tod6"
                       )
                     ),
                     actionBttn("save_tod", 
                                label = "Save Project Data", 
                                style = "material-flat",
                                size = "sm", 
                                color = "primary")
            ) #tabpanel
          ) #tab box
        ) # fluid row
      ), # tabitem
      # tab for tasks ----
        tabItem(
          
          tabName = "item3",
          fluidRow(
            
            tabBox(
              title = tags$b("Add and Edit Tasks"),
              #collapsible = TRUE,
              #solidHeader = TRUE,
              #status = "primary",
              width = 12, 
              id = "task_box",
              # add project ----
              tabPanel("Add Task",
                       textInput(
                         inputId = "add_info_task",
                         label = "Task Information"
                       ),
                       selectInput(
                         inputId = "add_project_task",
                         label = "Associated Task Project",
                         choices = c("None" = "none", 
                                     "SPAML" = "spaml", 
                                     "Table of Doom" = "tod"),
                         selected = NULL,
                         multiple = FALSE,
                         selectize = TRUE
                       ),
                       selectInput(
                         inputId = "add_user_task",
                         label = "Associated User",
                         choices = c("None" = "none", 
                                     "Erin Buchanan" = "0000-0002-9689-4189", 
                                     "Savannah Lewis" = "0000-0002-9689-5864",
                                     "John Smith" = "0000-0002-5827-2084"),
                         selected = NULL,
                         multiple = FALSE,
                         selectize = TRUE
                       ),
                       actionBttn("save_new_task", 
                                  label = "Create New Task", 
                                  style = "material-flat",
                                  size = "sm", 
                                  color = "primary")
              ),
              # spaml ----
              tabPanel("Edit Tasks", 
                       fluidRow(
                         DTOutput("current_task_table"),
                         actionBttn("edit_tasks", 
                                    label = "Save Task Data", 
                                    style = "material-flat",
                                    size = "sm", 
                                    color = "primary")
                         ) # close fluidrow
                       ) # close tabpanel
              ) # close tabbox
            ) #fluidrow
          ) #tabItem
      ) # overall tabitems
    ) # dashboard body
            