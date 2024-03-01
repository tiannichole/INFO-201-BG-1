## Styling

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Inconsolata:wght@200..900&display=swap');
      body {
        background-color: black;
        color: black;
      }
      p {
        font-family: 'Inconsolata', monospace;
      }
      h1 {
        font-family: 'Inconsolata', monospace;
        margin-bottom: 300px;
      }
      "))
  ),

  ## OVERVIEW TAB INFO
  
  overview_tab <- tabPanel("Final Project",
     h1("Seattle Pet Licenses and Income"),
     p("Research by Hannah Hinton, Nichole Tian, and Xiwen Wang")
  ),
  
  ## VIZ 1 TAB INFO
  
  viz_1_sidebar <- sidebarPanel(
    h2("Options for graph"),
    #TODO: Put inputs for modifying graph here
  ),
  
  viz_1_main_panel <- mainPanel(
    h2("Vizualization 1 Title"),
    # plotlyOutput(outputId = "your_viz_1_output_id")
  ),
  
  viz_1_tab <- tabPanel("Viz 1 tab title",
    sidebarLayout(
      viz_1_sidebar,
      viz_1_main_panel
    )
  ),
  
  ## VIZ 2 TAB INFO
  
  viz_2_sidebar <- sidebarPanel(
    h2("Options for graph"),
    #TODO: Put inputs for modifying graph here
  ),
  
  viz_2_main_panel <- mainPanel(
    h2("Vizualization 2 Title"),
    # plotlyOutput(outputId = "your_viz_1_output_id")
  ),
  
  viz_2_tab <- tabPanel("Viz 2 tab title",
    sidebarLayout(
      viz_2_sidebar,
      viz_2_main_panel
    )
  ),
  
  ## VIZ 3 TAB INFO
  
  viz_3_sidebar <- sidebarPanel(
    h2("Options for graph"),
    #TODO: Put inputs for modifying graph here
  ),
  
  viz_3_main_panel <- mainPanel(
    h2("Vizualization 3 Title"),
    # plotlyOutput(outputId = "your_viz_1_output_id")
  ),
  
  viz_3_tab <- tabPanel("Viz 3 tab title",
    sidebarLayout(
      viz_3_sidebar,
      viz_3_main_panel
    )
  ),
  
  ## CONCLUSIONS TAB INFO
  
  conclusion_tab <- tabPanel("Conclusion Tab Title",
   h1("Some title"),
   p("some conclusions")
  )
  
)

ui <- navbarPage("INFO 200 BG-1",
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 conclusion_tab
)