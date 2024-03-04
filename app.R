 install.packages("shiny")
 install.packages ("shinyWidgets")
 install.packages("ggplot2")
 install.packages("tidyverse")
 install.packages("lubridate")
 install.packages("eeptools")
 install.packages("plotly")
 install.packages("data.table")
 install.packages("dplyr")


library(tidyverse)
library(lubridate)
library(eeptools)
library(shiny)
library (shinyWidgets)
library(ggplot2)
library(plotly)
library(data.table)
library(dplyr)


source("ui.R")
source("server.R")



shinyApp(ui = ui, server = server)
