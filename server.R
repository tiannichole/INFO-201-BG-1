library(tidyverse)
library(lubridate)
library(eeptools)
library(shiny)
library (shinyWidgets)
library(ggplot2)
library(plotly)
library(data.table)
library(dplyr)

server <- function(input, output, session){
  
  ##read in data#
  library(readr)
  pet_df <- read_csv("pet_df.csv")

  ## add font styling to be consistent with overall ui
  font_style <- theme(text = element_text(family = "Inconsolata", color = "black"))
  
  ###tab1###
  #SES 
  output$pet_plot <- renderPlot({
    ggplot(pet_df %>% filter(Species == input$species), aes(License.Issue.Date, Avg.AGI, colour = SES)) + 
      geom_point() + font_style
  }, res = 96)
  
  # output$test_plot <- renderPlot({
  #  ggplot(pet_df, aes(fill=Species, y=count(Species), x=SES)) + 
  #     geom_bar(position="dodge", stat="identity")
  # })
  
  ##tab2###
  #countplot
  counts <- reactive ({
    pet_df%>%
      filter(Species == input$species) %>%
      count("Primary.Breed") %>%
      mutate(percentage = (n / sum(n)) * 100)
  })
  
  ##TEST##############
  output$breed_plot <- renderPlot({
    ggplot(aes(x=Primary.Breed, y=freq) ) +
      geom_segment( aes(x=Primary.Breed ,xend=Primary.Breed, y=0, yend=freq), color="grey") +
      geom_point(size=3, color="#69b3a2") +
      coord_flip() +
      theme(
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        legend.position="none"
      ) +
      xlab("") + font_style 
  })
  ###tab2###
  selected_graph <- reactiveVal(NULL)
  # When a button is clicked, store the selected graph
  observeEvent(input$button1, {
    selected_graph("graph1")
  })
  
  observeEvent(input$button2, {
    selected_graph("graph2")
  })
  
  observeEvent(input$button3, {
    selected_graph("graph3")
  })
  
  # Render the plot based on the selected graph
  output$vis2 <- renderPlot({
    if (is.null(selected_graph())) {
      return(NULL)
    }
    
    if (selected_graph() == "graph1") {
      #input graph1 here
      #Species breakdown
      species_count <- pet_df %>%
        count(Species)
      species_count <- species_count %>%
        mutate(percentage = (n / 14025) * 100)
      ggplot(species_count, aes(x="Percent of each species in our dataset", y=percentage, fill=Species))+
        geom_bar(width = 1, stat = "identity") +
        labs(caption = "As you can see, our dataset mainly consists of dogs and cats") + font_style 
      
    } else if (selected_graph() == "graph2") {
      #input graph2 here
      #socioeconomic status (based on AGI) breakdown
      #looking at our range of AGI
      SES_count <- pet_df %>%
        count(SES, na.rm=TRUE)
      SES_count <- SES_count %>%
        mutate(percentage = (n / 14025) * 100)
      ggplot(SES_count, aes(x="Percent of each Socioeconomic Status in our dataset 
                            (proxied by Annual Gross Income)", y=percentage, fill=SES))+
        geom_bar(width = 1, stat = "identity") +
        scale_fill_discrete(name = "Annual Gross Income (AGI) Category") +
        labs(caption = "As you can see, our dataset contains very few people who  
         earn less than $50,000 annually. Subsequently, this sample
         is likely biased towards people who can afford Pet Licenses") + font_style 
      
    } else if (selected_graph() == "graph3") {
      #input graph3 here
      #looking at years
      year_count <- pet_df %>%
        count(Year)
      year_count <- year_count %>%
        mutate(percentage = (n / 14025) * 100)
      ggplot(year_count, aes(x="Percent of each Year in our dataset", y=percentage, fill=Year))+
        geom_bar(width = 1, stat = "identity") +
        labs(caption = "As you can see, our dataset mainly consists of Pet License data from 2022.") + font_style 
    }
  })
  
  ###tab3###
  output$plot3 <- renderPlot({
    ggplot(pet_df, aes_string(x = input$x_variable, y = input$y_variable)) +
      geom_point() +
      labs(title = paste("Scatter Plot of", input$x_variable, "vs", input$y_variable)) + font_style 
  })
  
}
