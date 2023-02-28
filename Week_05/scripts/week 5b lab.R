## Today we will work on more data wrangling
## Created by: Chloe Mintlow 
## Updated on 2023-02-23

install.packages("lubridate")
library(tidyverse)
library(here)
library(lubridate)
now() #what time is it now 
now(tzone = "EST") #what time is it on east coast
today() #today's date
am(now()) #is it morning. true or false
#dates must be a character (")for lubridate to work
ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")    
mdy_hms("02/24/2021 22:22:20")
datetimes<-c("02/24/2021 22:22:20", #chacacter string
             "02/15/2021 11:21:10", 
             "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes) #convert to datetimes. #always mutate
month(datetimes)
month(datetimes, label = TRUE)
month(datetimes, label = TRUE, abbr = FALSE) #spell out months
day(datetimes) # extract day 
wday(datetimes, label = TRUE) #extract day of week
hour(datetimes)
minute(datetimes)
second(datetimes)
datetimes + hours(4) #adds 4 hrs; adds (s); helpful when converting to diff timezone
#hour() extracts hour component from time & hours() can add hours to datetime
datetimes + days(2) #adds 2 days
#day() extracts the hour component from a time and days() is used to add hours to a datetime
round_date(datetimes, "minute") #round to nearest minute
round_date(datetimes, "5 mins") #round to nearest 5 min
CondData<-read_csv(here("Week_05", "data", "CondData.csv")) %>% #load data
  mutate(Date = mdy_hm(Date)) #convert data column to datetime
#mutate*
glimpse(CondData)
View(CondData)
library(devtools)                   
install_github("Gibbsdavidl/CatterPlots") # install the data
library(CatterPlots)
x <-c(1:10)# make up some data
y<-c(1:10)
catplot(xs=x, ys=y, cat=3, catcolor='blue')

#lab
library(tidyverse)
library(here)
library(lubridate)
CondData<-read_csv(here("Week_05", "data", "CondData.csv")) %>%
  mutate(date = mdy_hms(date), 
         date = round_date(date, "10 secs"))
glimpse(CondData)
View(CondData)
DepthData<-read_csv(here("Week_05", "data", "DepthData.csv"))
glimpse(DepthData)
View(DepthData)
CombinedData1<- inner_join(CondData, DepthData) %>% #Combined condData & DepthData
  mutate(minutes = minute(date)) %>% 
  group_by(minutes) %>%
  summarise(Depth_mean = mean(Depth, na.rm = TRUE), 
           Temperature_mean = mean(Temperature, na.rm = TRUE), 
           Salinity_mean = mean(Salinity, na.rm = TRUE),
           date_mean = mean(date, na.rm = TRUE)) %>% 
  ggplot(data = CombinedData, 
         mapping = aes(x=minutes,  
                       y=Salinity_mean)) + 
  geom_line() + 
  labs(title = "Salinity for Each Minute",
       x = "Minutes", 
       y = "Salinity") + 
  theme(axis.title = element_text(size = 12, 
                                  color = "darkgreen"), 
        plot.title = element_text(hjust = 0.5, 
                                  size = 14))

ggsave(here("Week_05", "output", "lubggplot.png"))
