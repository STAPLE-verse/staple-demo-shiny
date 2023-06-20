
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
  right = "2023"
)

# body nav ----------------------------------------------------------------

body_nav <- 
  dashboardBody(
    tabItems(
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
            tabPanel("Edit User", 
                     DTOutput("orcid_table"), 
                     actionBttn("user_save_button", 
                                label = "Save User Edits", 
                                style = "material-flat",
                                size = "lg", 
                                color = "primary")),
            
            tabPanel("Add User",
                     p("Note. This demo doesn't work because rorcid no longer works."), 
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
                     )
            ) # box
          ) #fluidrow
      ), #tabItem
      tabItem(
        tabName = "item2",
        fluidRow(
          lapply(1:3, FUN = function(i) {
            sortable(
              width = 4,
              p(class = "text-center", paste("Column", i)),
              lapply(1:2, FUN = function(j) {
                box(
                  title = paste0("I am the ", j, "-th card of the ", i, "-th column"),
                  width = 12,
                  "Click on my header"
                )
              }) # lapply
            ) # sortable
          }) #lapply
        ) #fluidrow
      ) #tabItem
    ) #tabItems the whole thing
  ) #dashboardbody 
