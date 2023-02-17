## Today we will plot penguin data again ##
## Created by: Chloe Mintlow #
## Updated on: 2022-02-14 ##

#Load Libraries# 
library(palmerpenguins)
library(tidyverse)
library(here)

# Load data # 
# Data is part of package & called penguins#
glimpse(penguins)
#creates logical of true or false; keep rows that satisfy conditions
head(penguins) #before filter
filter(.data = penguins, sex == "female") #statment, == is this only female?
## 1 = sets argument in function; 2 == reads as 'exactly equal to', returns TRUE OR FALSE
#1  filter: data = penguins, year = 2008
#2. filter: data = penguins, body_mass_g > 5000) 
filter(.data = penguins, year == 2008|2009) #collected in either 2008 or 2009
filter(.data = penguins, island != "Dream") #not from island dream
filter(.data = penguins, species == "Adelie" & "Gentoo") #penguin in species Adelie & Gentoo
filter(.data = penguins, year == "2008"| year == "2009") #penguins collected 2008 or 2009 (alt. option)
filter(.data = penguins, species %in% c("Adelie", "Gentoo")) #alt way to show penguins in species Adelie & Gentoo
data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000)
data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000)
glimpse(penguins)
library(palmerpenguins)
library(tidyverse)
library(here)
glimpse(penguins)
data
data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000,
              bill_length_depth = bill_length_mm/bill_depth_mm) ##change multiple columns
  ## convert mass --> kg, calculate ratio of bill length to depth
data2<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) #if year is 2008 
View(data2) # shows before2008; #ifelse

#create new column to add flipper length & body mass
data2<-mutate(.data = penguins, 
              flipper_length_mm + body_mass_g)
View(data2)

#create new column so body mass greater than 4000, labeled big & everything else small

data2<- mutate(.data = penguins, greater_4000=ifelse(body_mass_g>4000, "Big", "Small"))
View(data2)
# %>% (pipe) OR |> = and then, sequence of events
penguins %>% #use penguin dataframe
filter(sex == "female") %>% #select female; remember to assign data a name to save
mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
select(species, island, sex, log_mass) #pulls entire column in your order;
  #new name = old to rename in select

## how to summarize data & calculate mean flipper lengtj
penguins %>%  #
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE))
#na.rm removes any NA values

#calculate mean & mean flipper length
summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE), 
          min_flipper = min(flipper_length_mm, na.rm=TRUE))
#use group_by to summarize by diff groups
#if summarise() has group
  drop_na(sex) %>% #drop ALL NA values
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))
  
#pipe into ggplot; use pipe %>% to manipulate data
  penguins %>%
    drop_na(sex) %>%
    ggplot(aes(x = sex, y = flipper_length_mm)) +
    geom_boxplot()
library(devtools)
devtools::install_github("jhollist/dadjokeapi")  
dadjokeapi::groam()
install.packages("dadjokeapi")

library(dadjokeapi)
dadjokeapi()

#1 mean & var body mass by species, sex, & island
penguins %>%  #
  group_by(species, island, sex) %>%
  summarise(mean_body_mass_g = mean(body_mass_g, na.rm=TRUE))
penguins %>%
  group_by(species, island, sex) %>%
  summarise(var_body_mass_g = var(body_mass_g, na.rm = TRUE))

#2 filter out male penguin
filter(.data = penguins, sex != "male") %>%
  mutate(log_mass = log(body_mass_g)) %>% 
  select(species, island, sex, log_mass) %>% 
  ggplot(data=penguins, #3 make ggplot
         mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot()+ 
  labs(x = "Species", 
       y = "Body Mass (g)", 
       title = "Body Mass of Penguin Species") + 
  scale_fill_viridis_b() +
  theme_grey() + 
  theme(axis.title = element_text(size = 10), 
        panel.background = element_rect(fill = "lavender"), 
        panel.grid = element_line(color = "grey"),
        plot.title = element_text(hjust = 0.5))
        
ggsave(here("Week_04", "output", "4alabggplot.png"))
