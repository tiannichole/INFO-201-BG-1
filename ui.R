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
       h1("Pets, Money, and City Tradeoffs: An Analysis of Seattle’s Pet Licenses"),
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
         a("click here!", href = "https://www.irs.gov/statistics/soi-tax-stats-individual-income-tax-statistics-zip-code-data-soi", target = "_blank"),
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
             h1("Our findings:"),
             p("The following significant findings from the examination of 
                Seattle's pet license data and its relationship to 
                socioeconomic variables provide light on particular areas of 
                the project's focus:", 
                style = "font-size: 16px;"),
             br(),
             img(src = "https://i.pinimg.com/originals/02/a3/3d/02a33dfffae193dd9c206430245670ef.png",
                 width = "300px",
                 height = "300px"),
             br(),
             br(),
             br(),
             p("1. Income Gaps and Pet Ownership:", 
                style = "font-size: 20px;"),
             p("According to the data, there is a significant relationship 
                in Seattle between pet ownership and wealth. Higher rates of 
                pet licensing are typically found in higher income areas, 
                indicating a possible relationship between pet ownership and 
                socioeconomic standing. This observation underscores the 
                impact of monetary assets on the inclination to become a pet 
                owner and the ramifications for home dynamics across various 
                social strata.", 
                style = "font-size: 18px;"),
             br(),
             p("2. City Governance and Pet Licensing Practices:", 
                style = "font-size: 20px;"),
             p("Analyzing pet licensing data highlights how important city 
                governance is to controlling and encouraging ethical pet 
                ownership. The efficiency of the present licensing procedures 
                and enforcement tools is called into doubt by differences 
                in license renewal rates and the fabrication of pet ownership 
                statistics. This realization highlights how crucial it is to 
                have fair and open governance practices in order to guarantee 
                legal compliance and advance the welfare of both dogs and 
                their owners.", 
                style = "font-size: 18px;"),
             br(),
             p("3. Education and Awareness:", 
                style = "font-size: 20px;"),
             p("The project emphasizes the importance of education and 
                awareness campaigns in influencing the attitudes and behaviors 
                associated with pet ownership. The necessity of focused 
                communication initiatives is highlighted by the 
                misrepresentation of pet ownership rates caused by variables 
                including disparities in enforcement and ignorance of 
                licensing requirements. Cities may improve the welfare of 
                pets and their communities by raising public awareness of 
                license requirements and the advantages of responsible pet 
                ownership. This will also help to increase compliance and 
                lessen inequities.", 
                style = "font-size: 18px;"),
             br(),
             p("These revelations highlight the complex interplay among 
                wealth, local government, and pet ownership. Cities like 
                Seattle can foster a more equitable and welcoming environment 
                for pet owners from all socioeconomic backgrounds by 
                addressing inequities, enhancing governance procedures, and 
                placing a high priority on awareness and education. Cities 
                can create policies and programs that support responsible pet 
                ownership and improve the quality of life for both pets and 
                their human partners by doing ongoing research and working 
                together with government agencies, community organizations, 
                and pet owners.",
                style = "font-size: 18px;"),
             br(),
             p("We believe in the future for Seattle in which people 
                collaborate and come up with creative solutions to ensure that 
                every pet owner practices responsible pet ownership, that 
                every pet receives care and support, and that there is a 
                vibrant, welcoming community for both pet owners and their 
                animals.",
                style = "font-size: 18px;"),
             img(src = "https://gifdb.com/images/high/mochi-cat-sweet-cheek-kiss-rmtmm2ovw6xecuml.gif",
                width = "400px",
                height = "325px"),
             p("Thank you for your interest in our project!",
                style = "font-size: 20px;")
    )
    )
    
  )
