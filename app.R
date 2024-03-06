 install.packages("shiny")
 install.packages("shinyWidgets")
 install.packages("ggplot2")
 install.packages("tidyverse")
 install.packages("lubridate")
 install.packages("eeptools")
 install.packages("plotly")
 install.packages("data.table")
 install.packages("dplyr")
 install.packages("rsconnect")
 install.packages("read.r")
 install.packages("bs.lib")
 install.pcakages("tidyverse")
install.packages("RColorBrewer")
install.packages("scales")
 
 library(tidyverse)
 library(lubridate)
 library(eeptools)
 library(shiny)
 library(shinyWidgets)
 library(ggplot2)
 library(plotly)
 library(data.table)
 library(dplyr)
 library(rsconnect)
 library(bslib)


library(shiny)

source("ui.R")
source("server.R")

library(rsconnect)


shinyApp(ui = ui, server = server)
