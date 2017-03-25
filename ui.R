
header = dashboardHeader(
  title = "Fish Mercury"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Mercury Sampling Events", tabName = "locations", icon = icon("map-marker"))
    #menuItem("Heat Map", icon = icon("bullseye"), tabName = "graphs")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "locations",
            fluidRow(
              column(width = 8,
                     box(title= "Fish Mercury Pollution in Ontario, Canada", width = NULL, solidHeader = TRUE,
                         #background = "light-blue",
                         leafletOutput("mercurymap", height = 600)
  )
    ),
  
column(width=4,
         box(title="Mercury Histogram", solidHeader=TRUE,
           background = "aqua",
           width = NULL,
           collapsible = TRUE,
           plotOutput("HgHist", height=550)
         )),
  
  column(width=8,
         box(#title="Select time window",
           background = "light-blue",
           # solidHeader = TRUE,
           width=NULL,
           collapsible=TRUE,
           dateRangeInput("daterange", "Select date range:",
                          start = "1990-01-01",
                          end   = "2000-12-31",
                          min = "1970-01-01",
                          max = "2015-12-31"),
           actionButton("updateButton", "Create / Update Map")
           # verbatimTextOutput("adf")
         )),
  
  column(width=4,
         box(#title='Select fish', #solidHeader=TRUE,
             background = "aqua",
             width = NULL,
             collapsible = TRUE,
             radioButtons("fishspecies", "Select fish species:", choices= c("Walleye", "Lake Trout", "Smallmouth Bass",
                                                                    "Largemouth Bass", "Northern Pike"))
             # actionButton("refreshButton", "Draw timeline")
         ))
  
            )),
    
    tabItem(tabName = "graphs",
            h2("Show data summaries")
    )
  )

)




dashboardPage(
  dashboardHeader(title = header),
  sidebar,
  body
)