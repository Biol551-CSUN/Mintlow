### This is my first. I am learning how to import data
### Created by: Chloe Mintlow
### Created on: 2023-02-02
### Load libraries ####
library(tidyverse)
library(here)
### Read in data ###
weightdata<-read_csv(here("Week_02","data","weightdata.csv"))
### Data Analysis #### 
head(weightdata) ### looks at top 6 lines
tail(weightdata) ### looks at bottom 6 lines of dataframe
view(weightdata) ### opens in new window
