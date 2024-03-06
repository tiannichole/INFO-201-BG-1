library(tidyverse)
library(lubridate)
library(ggplot2)
library(plotly)
library(data.table)
library(dplyr)
library(rsconnect)
library(bslib)
library(RColorBrewer)
library(scales)


server <- function(input, output, session){
  
  ##read in data#
  library(readr)
  pet_df <- read.csv("https://github.com/tiannichole/INFO-201-BG-1/blob/main/pet_df.csv?raw=true")
  
  
  ## add font styling to be consistent with overall ui
  font_style <- theme(text = element_text(family = "Inconsolata", color = "black"))
  
  ###tab1###
  #SES 
  pet_df$License.Issue.Date <- as.Date(pet_df$License.Issue.Date)
  
  overall_min_AGI <- min(pet_df$Avg.AGI)
  overall_max_AGI <- max(pet_df$Avg.AGI)
  
  output$plot1 <- renderPlot({
    filtered_data <- pet_df %>%
      filter(License.Issue.Date >= input$dateRange[1] & License.Issue.Date <= input$dateRange[2],
             if (!is.null(input$speciesInput) && input$speciesInput != "All") Species == input$speciesInput else TRUE)
    
    ggplot(filtered_data, aes(x=License.Issue.Date, y=Avg.AGI, colour = Species)) + 
      geom_point() + 
      labs(
        x = "License Issue Date",
        y = "Average Annual Gross Income (by Zip Code)") +
      scale_x_date(date_breaks = "6 month", date_labels = "%b %Y") +  # Adjust x-axis scale
      ylim(overall_min_AGI, overall_max_AGI)  # Fix y-axis limits
  })
  
  ###tab2###
  selected_graph <- reactiveVal(NULL)
  
  observeEvent(input$button1, {
    selected_graph("graph1")
  })
  
  observeEvent(input$button2, {
    selected_graph("graph2")
  })
  
  observeEvent(input$button3, {
    selected_graph("graph3")
  })
  
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
      plot <- ggplot(species_count, aes(x=" ", y=percentage, fill=Species))+
        geom_bar(width = 1, stat = "identity") +
        labs(x = "Percent of each species in our dataset", y = "Percentage", caption = "As you can see, our dataset mainly consists of dogs and cats") +
        theme(text = element_text(family = "Inconsolata", color = "black"),
              plot.caption.position = "plot",
              plot.caption = element_text(hjust = 0))
      
      return(plot)
      
    } else if (selected_graph() == "graph2") {
      #input graph2 here
      #socioeconomic status (based on AGI) breakdown
      #looking at our range of AGI
      SES_count <- pet_df %>%
        count(SES, na.rm=TRUE)
      SES_count <- SES_count %>%
        mutate(percentage = (n / 14025) * 100)
      plot <- ggplot(SES_count, aes(x=" ", y=percentage, fill=SES))+
        geom_bar(width = 1, stat = "identity") +
        labs(x = "Percent of each Socioeconomic Status in our dataset 
             (proxied by Annual Gross Income) ", y = "Percentage", caption = str_wrap(" For the SES category, 'Low' is under $50,000 AGI, 'Medium' is $50,000 - $100,000 AGI, and 'High' is over $100,000 AGI. As you can see, our dataset contains very few people who earn less than $50,000 annually. Subsequently, this sample is likely biased towards people who can afford Pet Licenses")) +
        theme(text = element_text(family = "Inconsolata", color = "black"),
              plot.caption.position = "plot",
              plot.caption = element_text(hjust = 0))
      
      return(plot)
      
    } else if (selected_graph() == "graph3") {
      #input graph3 here
      #looking at years
      year_count <- pet_df %>%
        count(Year)
      year_count <- year_count %>%
        mutate(percentage = (n / 14025) * 100)
      plot <- ggplot(year_count, aes(x="", y=percentage, fill=Year))+
        geom_bar(width = 1, stat = "identity") +
        labs(x = "Percent of each year in our dataset", y = "Percentage", caption = "As you can see, our dataset mainly consists of pet license data from 2022.") +
        theme(text = element_text(family = "Inconsolata", color = "black"),
              plot.caption.position = "plot",
              plot.caption = element_text(hjust = 0))
      
      return(plot)
      
    }
  })
  
  ###tab3###
  tab3_df <- reactive({
    pet_df %>%
      filter(Species == input$species_var, SES == input$SES_var)
  })
  
  output$vis3_plot <- renderPlot({
    tab3_df_filtered <- tab3_df()
    
    breed_counts <- table(tab3_df_filtered$Primary.Breed)
    total_count <- sum(breed_counts)
    breed_proportions <- breed_counts / total_count
    
    #breeds with less than 1%
    other_breeds <- names(breed_proportions[breed_proportions < 0.01])
    
    #creating the "other" category and putting breeds with less than 1% into it
    tab3_df_filtered$Primary.Breed_Grouped <- ifelse(tab3_df_filtered$Primary.Breed %in% other_breeds, "Other (Species with less than 1% representation)", tab3_df_filtered$Primary.Breed)
    
    #recalculations
    breed_counts_grouped <- table(tab3_df_filtered$Primary.Breed_Grouped)
    breed_proportions_grouped <- breed_counts_grouped / sum(breed_counts_grouped)
    
    #df
    breed_data <- data.frame(Breed = names(breed_proportions_grouped), Proportion = breed_proportions_grouped)
    
    #color stuff
    nb.cols <- 30
    mycolors <- colorRampPalette(brewer.pal(8,"Set1"))(nb.cols)
    mycolors <- rep(mycolors, length.out = nb.cols)
    
    ggplot(breed_data, aes(x = "", y = breed_proportions_grouped, fill = Breed)) +
      geom_bar(stat = "identity") +
      labs(
        x = NULL,
        y = "Proportion",
        title = "Proportion of Dog Breeds (Grouped)"
      ) +
      coord_flip() +  
      scale_fill_manual(values = mycolors) +
      theme_minimal() +
      theme(
        legend.position="bottom",
        legend.direction="vertical",
        legend.margin=margin())
  })
  
}
