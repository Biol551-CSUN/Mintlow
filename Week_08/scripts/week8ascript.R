## This is my script on advanced plotting (plotting, ggrepel)
## Created by: Chloe Mintlow
## Updated on 2023-03-28 

# Load Data
install.packages("patchwork") ## bring plots together
install.packages("ggrepel") ## repel labels
install.packages("gganimate") ## animations
install.packages("magick") ## images 

library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins) 