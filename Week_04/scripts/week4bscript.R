## This is my script for week 4b. Today we will practice tidy with biogeochemistry data
## Created by: Chloe Mintlow
## Updated on: 2023-02-16

## Load Libraries ## 
library(tidyverse)
library(here)

## Load data ## 
ChemData<-read_csv(here("Week_04","data","chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)
ChemData_clean<-ChemData %>% 
  filter(complete.cases(.)) #filters out everything that's not a complete row
View(ChemData_clean)
?separate
ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% # keep the original tide_time column
  unite(col = "Site_Zone", # the name of the NEW col; unites 2 columns into one
        c(Site,Zone), # the columns to unite
        sep = ".", # lets put a . in the middle
        remove = FALSE) # keep the original
head(ChemData_clean) #separate data (deletes original column); to keep add "remove = FALSE"

#pivoting - wide to long: pivot_longer(); long to wide: pivot_wider()
ChemData_long <-ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, ## the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", ## the names of the new cols with all the column names
               values_to = "Values") ## names of the new column with all the values
View(ChemData_long)
#calculate mean & variance + standard dev within long data set
ChemData_long %>%
  group_by(Variables, Site) %>% # group by everything we want; must group by Variables & Site first
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE), # get variance
            Param_sd = sd(Values, na.rm = TRUE)) #get standard deviation
ChemData_long %>%
  group_by(Variables, Zone) %>% # group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean 
            Param_vars = var(Values, na.rm = TRUE), # get variance
            Param_sd = sd(Values, na.rm = TRUE)) #get standard deviation
ChemData_long %>%
  group_by(Variables, Tide) %>% # group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean 
            Param_vars = var(Values, na.rm = TRUE), # get variance
            Param_sd = sd(Values, na.rm = TRUE)) #get standard deviation
## summarise() has grouped output by 'Variables'. You can override using the
## .groups argument
ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")
ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values
View(ChemData_wide)
#make data long, summarise, & then bring back wide for cleaner data
ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row 
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide", "Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") %>% # names of the new column with all the values)
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% #mean_vals is now col
  write_csv(here("Week_04","output","summary.csv")) #export csv to output
View(ChemData_clean)
devtools::install_github("R-CoderDotCom/ggbernie@main")
library(ggbernie)
ggplot(ChemData) +
  geom_bernie(aes(x = Salinity, y = NN), bernie = "sitting")
1
