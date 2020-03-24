#Libraries
library(shiny)
library(ggplot2)

#creating the UI 
ui <- fluidPage(
    
    titlePanel("Shiny Test Data"),
    sidebarLayout(
        sidebarPanel(
            selectInput("gender",
                        "Select gender:",
                        c("Male"="M", 
                          "Female"="F",
                          "All"), 
                        selected = "All"),
            checkboxInput("preAugust", 
                          "Exclude data from tests completed before August 1, 2017",
                          FALSE)
        ),
        
        mainPanel(
            plotOutput("scatterPlot"),
            dataTableOutput("table")
        )
    )
)