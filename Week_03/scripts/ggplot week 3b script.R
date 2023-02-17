### Today we are going to plot penguin data ##
### Created by: Chloe Mintlow ##
## Updated on: 2023-02-09

library(palmerpenguins)
library(tidyverse)
library(here)

glimpse(penguins)
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm, group = species)) +
  geom_point()+ geom_smooth(method = "lm")+
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  )
?geom_smooth()
### use scale to change color/formatting
install.packages('devtools')
devtools::install_github("dill/beyonce")
library(beyonce)
par(mfrow=c(26,5))
for(i in 1:130) print(beyonce_palette(i))
plot1<-ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  scale_color_manual(values = beyonce_palette(10)) + 
  theme_classic() +
  theme(axis.title = element_text(size = 10, color = "violet"),
        panel.background = element_rect(fill = "turquoise"))
  # coord_flip("x") # flip x and y axes    
## learning how to use coordinates
#coord_flip() or coord_fixed()
#diamond shows relationship b/t diamond & carrot
ggplot(diamonds, aes(carat, price)) +
  geom_point()
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10")
##transform axis to specific coordinate system: coord_polar("x")
#each element associated w certain element. specify non-data elements
p + theme_light(base_size = 14)
install.packages("ggthemes")
library(ggthemes)
#change text: element_text ; done for reports & projects
##element_rect (fill) changes fill color; color would only change outline
?theme()
?element_rect()
#edit width & height of plot
ggsave(here("Week_03","output","penguin.png"),
width = 7, height = 5) #in inches

##lab: group plot
       ggplot(data=penguins, 
              mapping = aes(x = body_mass_g, fill = island)) + 
         geom_histogram(col = I("black")) + 
         labs(x = "Body mass (g)",
         y = "Count", 
       fill = "Island") +
         theme_bw() + 
         theme(axis.title = element_text(size = 10, 
                                         color = "black"), 
               panel.grid = element_line(color = "lightgrey"), 
               panel.background = element_rect(fill = "beige"),
               legend.key = element_rect(fill = "beige"),
               plot.title = element_text(size = 10, hjust = 0.5, face = "bold")) +
         ggtitle("Body Mass in Penguins Grouped by Islands") +
         scale_fill_brewer(palette = "Accent") 
       ggsave(here("Week_03", "output","penguin.png"))
#face = "bold" to bold title
       # hjust 0.5 : centers title ; hjust = justification
       # scale fill brewer changes color for island bars
       #(col = I("black")) made dark borders within plot/histogram
       #fill = "Island" capitalized the "I" in legend
       
       #make repository
       