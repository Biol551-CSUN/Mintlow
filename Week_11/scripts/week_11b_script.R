## My Week 11b Script Working with Factors
## Created by: Chloe Mintlow
## Updated on: 2023-04-20 

### Load Libraries
library(here)
library(tidyverse)

### Retrieve Data
tuesdata <- tidytuesdayR::tt_load(2021, week = 7)
income_mean<-tuesdata$income_mean
#income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv') #alternative load


#factor = specialized version of character; levels = values a factors takes, order specifically
fruits<-factor(c("Apple", "Grape", "Banana"))
fruits
test<-c("A", "1", "2")
as.numeric(test)

test<-factor(test) #converts to factor
as.numeric(test)
#read_csv --> string, read.csv --> factor/character

### Use Starwars Data
glimpse(starwars)
star_counts<-starwars %>% 
  filter(!is.na(species)) %>% #remove NAs 
  mutate(species = fct_lump(species, n = 3)) %>% 
  count(species)
#fct_lump converts data into factor & lumps together

### Make plot 

star_counts %>% 
  ggplot(aes(x = fct_reorder(species, n), y = n)) +  #what you reorder first, by how you reorder for fct
  geom_col() + 
  labs(x = "Species")

#OR species, n, .desc = TRUE for opp way

### Use Income Mean Data
glimpse(income_mean)
total_income<-income_mean %>% 
  group_by(year, income_quintile)%>% 
  summarise(income_dollars_sum = sum(income_dollars))%>% 
  mutate(income_quintile = factor(income_quintile)) #make factor, always use mutate before reordering column

# plot 
total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum)))+ #<< fct_reorder2 to organize
  geom_line()+
  labs(color = "income quantile"))

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))
x1

### Back to starwars
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% #remove general NA
  count(species, sort = TRUE) %>% 
  mutate(species = factor(species)) %>% #make species factor
  filter(n>3) %>% #only species more than 3
  droplevels() %>% #drops extra levels & prevent NAs
  mutate(species = fct_recode(species, "Humanoid" = "Human")) #new name goes first, new = old
starwars_clean

#Awesome R Package
play music