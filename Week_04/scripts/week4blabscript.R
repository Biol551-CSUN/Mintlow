## This is my new script for today's lab with chemistry data
## Created by: Chloe Mintlow
## Updated on: 2023-02-16

## Load Libraries ## 
library(tidyverse)
library(here)

## Load data ##
ChemData<-read_csv(here("Week_04","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)
ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #cleans & filters out data not in a complete row; or use drop_na
  separate(col = Tide_time, #choose tide time column
           into = c("Tide", "Time"), #separate into 2 columns: Tide & Time
           sep = "_", #separate by
           remove = FALSE) %>% #keep OG column
  filter(Time == "Night") %>%
  pivot_longer(cols = Salinity:percent_sgd, ## the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", ## the names of the new cols with all the column names
               values_to = "Values")
ChemData_long %>% 
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_sd = var(Values, na.rm = TRUE), # get variance
            Param_median = median(Values, na.rm = TRUE)) #get median
ChemData_long %>%
group_by(Variables, Season) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_sd = var(Values, na.rm = TRUE), # get variance
            Param_median = median(Values, na.rm = TRUE)) # get median
ChemData_long %>%
  group_by(Variables, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_sd = var(Values, na.rm = TRUE), # get variance
            Param_median = median(Values, na.rm = TRUE)) #get median
ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values 
ChemData_clean<-ChemData %>%
  drop_na() %>% 
  separate(col = Tide_time, #choose tide time column
           into = c("Tide", "Time"), #separate into 2 columns: Tide & Time
           sep = "_", #separate by
           remove = FALSE) %>% #keep OG column 
  filter(Time == "Night") %>%
  pivot_longer(cols = Salinity:percent_sgd, ## the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", ## the names of the new cols with all the column names
               values_to = "Values") %>% 
  group_by(Variables, Site, Season) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% 
  pivot_wider(names_from = Variables, 
               values_from = mean_vals)
  ChemData_clean %>% 
    ggplot(aes(x = Site, y = Salinity)) + 
    geom_dotplot()+ 
    facet_wrap(~Salinity)
  ChemData_long %>%
    ggplot(aes(x = Season, y = Values, #make plot
               group = Season, 
               color = Season)) + 
    geom_line()+  
    facet_wrap(~Variables, scales = "free") + 
    labs(x = "Seasons", 
         y = "Range of Values for Each Season", 
         title = "A Range of Fall and Spring Values from ChemData") +
  scale_color_manual(values = c("pink", "turquoise"))+ 
      theme_bw() +
    theme(axis.title = element_text(size = 10),
          panel.background = element_rect(fill = "linen"))
    ggsave(here("Week_04", "output", "labggplot.png"), width = 5, height = 5, units = "in")
  
    write_csv(here("Week_04","output","newlabsummary.csv"))  # export as a csv to the right folder
head(ChemData_clean)
View(ChemData_clean)

