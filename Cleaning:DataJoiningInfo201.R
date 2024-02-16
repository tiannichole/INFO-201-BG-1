###Hey, so not sure if I'm doing this right, but hoping you guys can see the code I made to clean the data :)###

library(tidyverse)
library(eeptools)

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

