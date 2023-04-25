## This is my Week 12a Script on Iterative Coding
## Created by: Chloe Mintlow
## Updated on: 2023-02-25 

# Load Libraries 
library(tidyverse)
library(here)

# Retrieve Data
onepcalcond <- read.csv('https://raw.githubusercontent.com/Biol551-CSUN/Spring-2023/main/Week_12/data/cond_data/011521_CT316_1pcal.csv')
twopcalcond <- read.csv('https://raw.githubusercontent.com/Biol551-CSUN/Spring-2023/main/Week_12/data/cond_data/011621_CT316_1pcal.csv')
threepcalcond <- read.csv('https://raw.githubusercontent.com/Biol551-CSUN/Spring-2023/main/Week_12/data/cond_data/011721_CT354_1pcal.csv')

#forloops is a way to run iterative process
#command 4 "forloops": for(index in sequence){command to repeat}, b/t 1-10 will repeat command
print(paste("The year is", 2000))
years<-c(2015:2021)
for (2001 in years){ 
  print(paste("The year is, 2001")) 
} #loop over i

year_data<-data.frame(matrix(ncol = 2, nrow = length(years))) #pre-allocate space, matrix = size that you expect out put to be w/ column names
colnames(year_data)<-c("year", "year_name") #dd column name

year_data

#simple for loop
for (i in 1:length(years)){ #set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) #loop over year name
  year_data$year[i]<-years[i] #loop over year, w/o this year = NA
}

year_data

#use for loop to read multiple csv
testdata<-read_csv(here("Week_12", "data", "cond_data","011521_CT316_1pcal.csv")) 
glimpse(testdata) 

CondPath<-here("Week_12", "data", "cond_data") #point to location on computer
# list all the files in that path with a specific pattern
# In this case we are looking for everything that has a .csv in the filename
# you can use regex to be more specific if you are looking for certain patterns in filenames
files <- dir(path = CondPath,pattern = ".csv")

files 

#pre-allocate space for loop
# make an empty dataframe that has one row for each file and 3 columns
cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))
# give the dataframe column names
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")

cond_data

#for loop code 
raw_data<-read_csv(paste0(CondPath,"/",files[1]))  #paste adds a space, paste0 is no space
head(raw_data)
mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) #calculate mean 
mean_temp

#turn into a for loop 
for (i in 1: length(files)){ #loop over 1:3 number of files

raw_data<-read_csv(paste0(CondPath,"/",files[i])) 
glimpse(raw_data)  
cond_data$filename[i]<files[i]
cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
}

cond_data

#purr mapping cheatsheet
#map = list, #map_lgl = logical vector, map_int = integer vector, map_dbl = double vector 
#map_chr = character vector, map_df = 

1:10 #vector from 1 to 10 (10x)
1:10 %>% #vector 1 to 10, 10x to make 15 number of distribution
  map(rnorm, n = 15) %>% #calculate 15 numbers based on normal distribution
  map_dbl(mean) #calculate mean, now a vector "double"

#make your own function
1:10 %>% #list 1-10 
  map(function(x) rnorm(15, x)) %>% #make own function
  map_dbl(mean)

1:10 %>% #what vector is set for
  map(~ rnorm(15, .x)) %>% #change argument within function
  map_dbl(mean)

#Bring in files using purr instead of loop 
CondPath<-here("Week_12", "data", "cond_data") #point to location on computer
files <- dir(path = CondPath,pattern = ".csv")
#OR 
files

data<-files %>%
  set_names()%>% #set id of each list to file name
  map_df(read_csv, .id = "filename") %>% #map everything to dataframe
  group_by(filename) %>% 
  summarise(mean_temp = mean(Temperature, na.rm = TRUE), 
            mean_sal - mean(Salinity,na.rm = TRUE))

data

#Awesome R Package 
install.packages('gganatogram')

#2 identical dataframe. You have a set of 4 .csv files in data/homework. Each of these files is a timeseries of temperature and light data collected in tide pools in Oregon by Jenn Fields. Your goal is to bring in all 4 files and calculate the mean and standard deviation of both temperature (Temp.C) and light (Intensity.lux) for each tide pool.  Use **both** a for loop and map() functions in your script. (Basically, do it twice). Due Tuesday at 1pm. 
