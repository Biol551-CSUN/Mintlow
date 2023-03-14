## This is my script on ggmaps part 2 
## Created by: Chloe Mintlow
## Updated on: 2023-03-09

# Load Data
install.packages("ggmap") # for ggmaps
install.packages("ggsn") # to add scale bars and compass arrows
library(ggmap)
library(tidyverse)
library(here)
library(ggsn)

# Use Data 
register_google(key = "AIzaSyDHnY5hJHarSFnh5SOtlQpNE5DeajwBj5Q", write = TRUE) ### use my personal API
#IMPORTANT don't put your key to github!! I usually save mine in a text file and import it each time
# Setting write = TRUE will write the API key to your R environment so that you do not have to re register it each time

ChemData<-read_csv(here("Week_07","data","chemicaldata_maunalua.csv"))
glimpse(ChemData)
Oahu<-get_map("Oahu")
ggmap(Oahu)
#Make a data frame of lon and lat coordinates
WP<-data.frame(lon = -157.7621, lat = 21.27427) # coordinates for Wailupe
# Get base layer
Map1<-get_map(WP)
# plot it
ggmap(Map1)
Map1<-get_map(WP,zoom = 17)
ggmap(Map1)
Map1<-get_map(WP,zoom = 17, maptype = "satellite")
ggmap(Map1)
Map1<-get_map(WP,zoom = 17, maptype = "watercolor")
ggmap(Map1)

# Make Plot
Map1<-get_map(WP,zoom = 17, maptype = "satellite") 
ggmap(Map1)+
  geom_point(data = ChemData,
             aes(x = Long, y = Lat, color = Salinity),
             size = 4) +
  scale_color_viridis_c() +  
  scalebar( x.min = -157.766, x.max = -157.758,
                                   y.min = 21.2715, y.max = 21.2785,
                                   dist = 250, dist_unit = "m", model = "WGS84", 
                                   transform = TRUE, st.color = "white",
                                   box.fill = c("yellow", "white"))
geocode("the white house")
## # A tibble: 1 x 2
##     lon   lat
##   <dbl> <dbl>
## 1 -77.0  38.9
geocode("California State University, Northridge")
## # A tibble: 1 x 2
##     lon   lat
##   <dbl> <dbl>
## 1 -119.  34.2

## Awesome R Package
install.packages("emojifont")
library(emojifont)
search_emoji('smile')

ggplot() + 
  geom_emoji('smile_cat', 
             x=1:5, y=1:5, 
             size=10)
#first layer is base layer in maps, then use geom_point