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
            DT::dataTableOutput("table")
        )
    )
)

server <- function(input, output) {
    
    #Filter data so that plot and table will adjust accordingly
    filtered_data <- reactive({
        data <- for_shiny_tbl
        if (input$preAugust){
            data <- subset(data,
                           timeEnd > as.Date("2017-08-01"))
        }
        data
        if (input$gender != "All"){
            data <- subset(data,
                           gender == input$gender)
        }
        data
    })
    
    output$scatterPlot <-renderPlot({
        data <- filtered_data()
        ggplot(data, aes(Q1Q5means, Q6Q10means)) + 
            geom_point() + 
            geom_smooth(method = lm, se = FALSE) +
            labs(x = "Average scores on Q1 to Q5", 
                 y = "Average scores of Q6 to Q10",
                 title = "Average scores on Q1 to Q5 versus Average scores on Q6 to Q10")
    })
    
    output$table <- DT::renderDataTable({
        data <- filtered_data()
        data
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

