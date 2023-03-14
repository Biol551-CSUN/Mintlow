install.packages(c("maps", "mapproj", "mapdata"))
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj

# get data for the entire world 
world<-map_data("world")
head(world)

usa<-map_data("usa")
head(usa)
