## Today we will practice joins w/ data from Becky & Silbiger
## Created by: Chloe Mintlow 
## Updated on 2023-02-21

## Load Libraries 
library(tidyverse)
library(here)

## Load data 
#Environmental data from each site 
EnviroData<-read_csv(here("Week_05", "data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData<-read_csv(here("Week_05", "data","Topt_data.csv"))
glimpse(EnviroData)
glimpse(TPCData)
View(EnviroData)
View(TPCData)

#pivot data so both in same format
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>% 
  arrange(site.letter) #arrange dataframe by alphabetized site 
View(EnviroData_wide)

#left_join takes 2 data sets, joins by unique identifier & joins 2 dataframes into 1
FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) #where asks logical questions. #puts numeric data on left; puts characters on right
join_by(site.letter) #joins w unique identifier
head(FullData_left)
#calculate mean & variance of all collected TPC & environmental data by site
ThinkData <- FullData_left %>%
pivot_longer(cols= E:substrate.cover, #cols to pivot
             names_to= "variables", #names columns
             values_to= "values") %>%
  group_by(site.letter, variables) %>% 
  summarise(mean_vals = mean(values, na.rm=TRUE),
            var_vals = var(values, na.rm = TRUE))

#OR group_by(site.letter) %>% 
#   summarise_at(vars(E:substrate.cover))

#create tibble: tibble() aka dataframe
T1 <- tibble(Site.ID = c("A", "B", "c", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), #2nd tibble
         pH = c(7.3, 7.8, 8.1, 7.9))
left_join(T1, T2) #joins to T1
left_join(T2, T1)  #joins to T2
inner_join(T1, T2) #removes C; keeps data that is complete in both data sets (A, B & D)
inner_join(T2, T1)
full_join(T1, T2) #keeps everything
semi_join(T1, T2) #retains first columm 
anti_join(T1, T2) #keeps columns that are missing
install.packages("cowsay")
library(cowsay)
say("hello", by = "shark")
