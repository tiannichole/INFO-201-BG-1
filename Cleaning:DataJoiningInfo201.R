###Hey, so not sure if I'm doing this right, but hoping you guys can see the code I made to clean the data :)###


library(tidyverse)
library(eeptools)
library(ggplot2)
library(lubridate)

###Uploading the original csv files
#this is the pet licenses dataset we found
pet_licenses_df <- read.csv("/Users/hannahhinton/Desktop/Seattle_Pet_Licenses_20240216.csv") ###not sure how to make this upload properly on github

#this is the new income dataset that I think will work better for our project. It's from the IRS, so completely different source.
#https://www.kaggle.com/datasets/thedevastator/2013-irs-us-income-data-by-zip-code?resource=download
income_df <- read.csv("/Users/hannahhinton/Desktop/IRSIncomeByZipCode.csv") ###again, path from my computer, not sure how to switch it for github 


###DATA CLEANING####
#cleaning the data from income_df before combining it (we just need the zip codes and average american gross income)
income_df <- income_df %>%
  filter(
    STATE == "WA")
income_df <- subset(
  income_df, select = c("ZIPCODE", "Avg.AGI"))

# cleaning the data from pet_licenses_df before combining it (filtering out years that we don't need to eliminate rows; we can only have up to 25,000 in the final)
pet_licenses_df <- pet_licenses_df %>%
  filter(str_detect(License.Issue.Date, '2019|2020|2021|2022')) ###what years do we want? do we want to include 2013 because of our IRS data? 
# if we wanted to remove blanks for zip code, depends on our questions!
#pet_licenses_df <- pet_licenses_df %>%
#filter(pet_licenses_df, pet_licenses_df$ZIP.Code != "")

#changing the License.Issue.Date from a character to a date in the dataframe
pet_licenses_df$License.Issue.Date <- mdy(pet_licenses_df$License.Issue.Date)

#ADDING NUMERICAL VARIABLE ("year")
pet_licenses_df <- pet_licenses_df %>% 
  mutate(Year = year(License.Issue.Date))

####COMBINING DATASETS
#left joining the datasets
income_df <- income_df %>%
  rename(ZIP.Code = "ZIPCODE")

income_df <- income_df %>%
  mutate(ZIP.Code= as.character(ZIP.Code))

pet_licenses_AGI_df <-pet_licenses_df %>% 
  left_join(income_df)

###checking amounts of different variables so that I can better clean the data
pet_licenses_AGI_df %>% count(ZIP.Code)
class(pet_licenses_AGI_df$ZIP.Code)

###CLEANING ONCE JOINED 
#removed any NA values for zip code or avg.AGI to do any AGI analyses. Figured this isn't important for all of the questions, but would be for AGI-specific ones. 
AGI_analyses_df <- pet_licenses_AGI_df %>%
  filter_at(vars(ZIP.Code, Avg.AGI), all_vars(!is.na(.)))

###ADDING CATEGORICAL VARIABLE ("SES")
pet_licenses_AGI_df <- pet_licenses_AGI_df %>% 
  mutate(SES = cut(
    Avg.AGI,
    breaks = c(0, 50, 100, Inf),
    labels = c("Low", "Medium", "High")
    )
  )


#DATA SUMMARIZATION
#BARPLOT/PIECHART THING
#looking at our range of species
species_count <- pet_licenses_AGI_df %>%
  count(Species)
species_count <- species_count %>%
  mutate(percentage = (n / 14025) * 100)
ggplot(species_count, aes(x="Percent of each species in our dataset", y=percentage, fill=Species))+
  geom_bar(width = 1, stat = "identity")


#Scatterplot looking at the range of species in the context of AGI and date
ggplot(pet_licenses_AGI_df, aes(License.Issue.Date, Avg.AGI, colour = Species)) + 
  geom_point()

#####as you can see, it's mostly cat and dogs, and it's mainly between 2022 and 2023.
#####as far as AGI, it looks like most people in the dataset are above 50 and below 150 AGI, 
##### except for a cluster around 200 agi. 



#------------------------------------------------------
#random other stuff 
              
#Dogs in our dataset that are top 2022 dog names
#https://www.akc.org/press-releases/come-luna-come-max-american-kennel-club-reveals-popular-dog-names-2022/
              
#top_dog_names_girls: "Luna|Bella|Daisy|Lucy|Willow|Penny|Sadie|Maggie|Rosie|Ruby"
#top_dog_names_boys: "Max|Milo|Cooper|Charlie|Teddy|Tucker|Buddy|Bear|Rocky|Leo"
              
dog_df <- pet_licenses_AGI_df %>%
filter(Species == "Dog")
              
cat_df <- pet_licenses_AGI_df %>%
filter(Species == "Cat")
              
top_dog_name <- "Luna|Bella|Daisy|Lucy|Willow|Penny|Sadie|Maggie|Rosie|Ruby|Max|Milo|Cooper|Charlie|Teddy|Tucker|Buddy|Bear|Rocky|Leo"
dog_df <- mutate(dog_df, Is_Top_Name = str_detect(Animal.s.Name, top_dog_name))
              
is_top_name_count <- dog_df %>%
count(Is_Top_Name, sort = TRUE)


#top breeds?
top_breed <- function(type) {
  pet_licenses_AGI_df %>%
    filter(Species == type) %>%
    count(Primary.Breed) %>%
    slice_max(n) %>%
    pull(Primary.Breed)
  }

top_breed_dog <- top_breed("Dog")
top_breed_cat <- top_breed("Cat")

top_breed_graph <- function(type) {
  ggplot_fuel <-
    pet_licenses_AGI_df %>%
    filter(Species == type) %>%
    count(Primary.Breed) %>%
    mutate(percentage = (n / sum(n)) * 100)
  
    ggplot(ggplot_fuel, aes(x="Percent of each breed in our dataset", y=percentage, fill=Primary.Breed))+
      coord_polar("y") +
      theme_void()
    
    }
    
top_breed_graph("Dog")
top_breed_graph("Cat")