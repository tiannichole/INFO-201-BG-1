## Styling

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Inconsolata:wght@200..900&display=swap');
      body {
        color: black;
        margin: 5%;
        font-family: 'Inconsolata', monospace;
      }
      "))
  ),

  ## OVERVIEW TAB INFO
  navbarPage("INFO 200 BG-1",
    tabPanel("Introduction",
       h1("Seattle Pet Licenses and Income"),
       p("Research by Hannah Hinton, Nichole Tian, and Xiwen Wang"), 
       br(),
       img(src = "https://i.pinimg.com/originals/cc/d8/c2/ccd8c22894aaf6ffff0d4f36ae8edb92.jpg",
           width = "400px",
           height = "325px"),
       br(),
       br(),
       br(),
       p("For our final project, we sought to uncover the relationship 
          between pet ownership and income. To develop our analysis, we 
          used data from the City of Seattle on all active pet licenses 
          and data from the IRS on income by zip code.", 
          style = "font-size: 18px;"),
       br(),
       p("For the dataset from the City of Seattle on pet licenses ", 
          a("click here!", href = "https://data.seattle.gov/Community/Seattle-Pet-Licenses/jguv-t9rb/about_data", target = "_blank"),
          style = "font-size: 16px;"),
       p("For the dataset from the IRS on zip codes and income ", 
         a("click here!", href = "https://data.seattle.gov/Community/Seattle-Pet-Licenses/jguv-t9rb/about_data", target = "_blank"),
         style = "font-size: 16px;"),
       br(),
       p("Limitations and Misrepresentation:", 
         style = "font-size: 20px; font-weight: bold;"),
       p("Because our dataset uses information exclusively from government 
          sources, we are limited to the data collection practices utilized 
          by both the City of Seattle and the IRS. This means that instead of 
          looking at every pet owner in the City of Seattle, we have access to 
          only the pet owners with active pet licenses. Therefore, when we 
          attempt to discover the relationship between wealth and pet 
          ownership, what we are really discovering is the correlation between 
          wealth and pet licensing rates.",
         style = "font-size: 18px;"),
       p("Our research inherently excludes pet owners who do not purchase or 
          renew pet licenses for their household animals. However, we can make 
          various assumptions about pet licensing rates and the misrepresentation 
          of various income groups in our study.", 
          style = "font-size: 18px;"),
       p("First, we can assume that wealthier individuals choose to not license 
          their pets because they do not care as much about supporting the 
          welfare programs that the licensing fees support. For example, Seattle 
          pet licensing fees help fund emergency veterinary services for all 
          pets with active pet licenses and animal shelters. However, wealthy 
          individuals who can afford to purchase household pets from breeders 
          and not shelters might not care as much about supporting local shelters 
          with their licensing fees because they have fewer interactions with 
          these services. Additionally, wealthy individuals might also not 
          require assistance with emergency veterinary services, therefore not 
          seeing the value in paying the licensing costs. However, we could 
          also assume that wealthier individuals might have higher rates of 
          licensing because, relative to their average income, pet licensing 
          fees are cheaper. For example, a $30 license for a dog might be an 
          easy payment to make for people with higher incomes.", 
          style = "font-size: 18px;"),
       p("However, another reason pet owners might be misrepresented in our 
          study might be because of a lack of pet licensing enforcement. Using 
          numbers from the Seattle Animal Shelter, it’s estimated that only one 
          in five pets are properly licensed, and this disparity might be a 
          result of just a lack of awareness. Many Seattle residents online 
          claim that they simply just didn’t realize they had to license their 
          pets, and because the City of Seattle doesn’t have a unified system 
          to enforce pet licensing, many pet owners don’t realize they’re 
          harboring illegal animals in their homes. Additionally, failure to 
          license your pet can result in fines of up to $125, but since the 
          likelihood of such a citation is extremely low, many pet owners who 
          know about licensing regulations simply choose to ignore them.", 
          style = "font-size: 18px;"),
       p("As a result of these factors, various demographics of pet owners can 
          end up misrepresented in our study data.", 
          style = "font-size: 18px;")
    ),
    
    tabPanel("idk yet",
             sidebarLayout(
               sidebarPanel(
                 h2("Options"),
                 #TODO: Put inputs for modifying graph here
                 radioButtons(inputId="species", "Species:",
                              c("Dogs" = "Dog",
                                "Cats" = "Cat",
                                "Goats" = "Goat",
                                "Pigs" = "Pig")),
                            ),
               mainPanel(
                 # plotlyOutput(outputId = "vis1_plot")
                 plotOutput(outputId = "pet_plot")
                 
               )
             )
    ),
    tabPanel("Limitations of our data",
             sidebarLayout(
               sidebarPanel(
                 h2("Percent of each in our dataset:"),
                 #TODO: Put inputs for modifying graph here
                 actionButton("button1", "Species"),
                 actionButton("button2", "Socioeconomic Status"),
                 actionButton("button3", "Year")
               ),
               mainPanel(
                 # plotlyOutput(outputId = "your_viz_2_output_id")
                 plotOutput(outputId = "vis2")
               )
             )
    ),
    tabPanel("Investigate our dataset!",
             sidebarLayout(
               sidebarPanel(
                 h2("Options for graph"),
                 #TODO: Put inputs for modifying graph here
                 selectInput("x_variable", "Choose X-axis variable:", choices = colnames(pet_df)), 
                 selectInput("y_variable", "Choose Y-axis variable:", choices = colnames(pet_df))
               ),
               mainPanel(
                 h2("Vizualization 2 Title"),
                 # plotlyOutput(outputId = "your_viz_3_output_id")
                 plotOutput(outputId = "plot3")
               )
             )
    ),
    tabPanel("Conclusion",
             h1("Some title"),
             p("some conclusions")
    )
    )
    
  )

# tabPanel("Viz 3 tab title",
#          sidebarLayout(
#            sidebarPanel(
#              h2("Options for graph"),
#              #TODO: Put inputs for modifying graph here
#            ),
#            mainPanel(
#              h2("Vizualization 3 Title"),
#              # plotlyOutput(outputId = "your_viz_1_output_id")
                

#            )
#          )
# ),