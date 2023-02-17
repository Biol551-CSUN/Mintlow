### This is my week 3 script. I am learning how to make a ggplot2
### Created by Chloe Mintlow
### Updated 2023-02-07 
glimpse(penguins)
library(palmerpenguins) 
library (tidyverse)
glimpse(penguins)
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm, ###anything related to data-aes
                     y = bill_length_mm, 
                     color = species,
                     size = body_mass_g, alpha = flipper_length_mm)) + 
 geom_point(size = 2, alpha = 0.5) +
  labs(title = "Bill depth and length", ### creates new axis labels; NO data = settings
                      subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
                      x = "Bill depth (mm)", 
                      y = "Bill length (mm)",
                      color = "Species",
                      caption = "Source: Palmer Station LTER / palmerpenguins package")+
                      scale_color_viridis_d()
##species: row sex: column; basic plot
ggplot(penguins, 
       aes(x = bill_depth_mm,
           y = bill_length_mm))+
  geom_point()+
  facet_grid(species~sex) + ### always a grid
  facet_wrap(~ species, ncol=2) ### 1D helps functionality. ncol stacks a column
##diff version of plot w all data
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
       )) +
  geom_point()+
  scale_color_viridis_d()+
  facet_grid(species~sex)+ 
  guides(color = FALSE) ##this removes color legend
scale_color_continuous()
ggsave(here("Week_03", "output","practicepenguin.png"))
### naming scheme for scale: 1. scale 2. name of primary aesthetic (color, shape, etc) 3.
### any vector: put "c" in front of it. c = convector
## scale_x_continuous
###control breaks; multiple arguments within same function