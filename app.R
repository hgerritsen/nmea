library(shiny)
library(dplyr)
library(tidyr)

source('settings_and_functions.R')

# Define UI for app
ui <- fluidPage(
  
# Application title
   titlePanel("Visualizing NMEA Data with Shiny"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         actionButton("start_button", "Gear on Bottom"),
         sliderInput("start_slider",
                     "Gear on Bottom:",
                     min = as.POSIXct("2000-01-01 00:00:00"),
                     max = as.POSIXct("2000-01-01 00:10:00"),
                     value = as.POSIXct("2000-01-01 00:00:00"),
                     step=1,
                     timeFormat='%T')
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("plot1",height = "600px")
      )
   )  
)  
  
# Define server logic
server <- function(input, output, session) {

  sampled_data <- reactivePoll(settings$refresh*1000, session ,IsThereNewFile, ReadAllData)

  observeEvent(
    input$start_button,
    updateSliderInput(session,'start_slider',val=max(sampled_data()$datetime))
  )
  
  observe({
    nmea <- sampled_data()
    output$plot1<-renderPlot(makeplot(nmea,input))
    updateSliderInput(session,'start_slider',min=min(nmea$datetime),max=max(nmea$datetime))
  })
    
}


# Run the application 
shinyApp(ui = ui, server = server)

