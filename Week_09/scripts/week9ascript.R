## This is my Week 9 script on Functional Programming
## Created by: Chloe Mintlow
## Updated on: 2023-04-04

# Load Function
library(tidyverse)
library(palmerpenguins)
library(PNWColors) #PNW color palette

df <- tibble::tibble( 
  a = rnorm(10), 
  b = rnorm(10), 
  c = rnorm(10), 
  d = rnorm(10) 
)  

head(df) # default = bell shape ov 0, standard deviation of 1

#scale = value - min of value 

df<-df %>% #rescale every column individually (data in multiple columns)
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value) #write function
}
df %>%
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))

          
## 3 steps to create new function: 1. pick a name, 2. list inputs or arguments, 3: place developed code in function body 4. return values
## return tells what values we want returned 
rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}

temp_C <- (temp_F - 32) * 5 / 9 

#name function 
fahrenheit_to_celsius <- function() { 
}

#put in equation
fahrenheit_to_celsius <- function() { 
  temp_C <- (temp_F - 32) * 5 / 9
}

#decide on arguments
fahrenheit_to_celsius <- function(temp_F) { 
  temp_C <- (temp_F - 32) * 5 / 9
} 

#decide on what is being returned 
fahrenheit_to_celsius <- function(temp_F) { 
  temp_K <- (temp_C - 32) * 5 / 9 
  return(temp_C)
}
#step 5: test it 
fahrenheit_to_celsius(99) #gives answer 37.2

#write function to convert Celsius to kelvin (Kelvin = celsius + 273.15)
cels_kelvin_conversion <- function(temp_C) { 
  temp_K <-(temp_C + 273.15) 
  return(temp_K)
} 
cels_kelvin_conversion(19)


# Make plot into function w penguin dataset x is versatile, y, data changed

pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()

myplot<-function(){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

myplot<-function(data = penguins, x, y, lines=TRUE ){ #add new argument
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 

if(lines==TRUE){
ggplot(data, aes(x = {{x}}, y = {{y}}, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()
}
else{
  ggplot(data, aes(x = {{x}}, y = {{y}}, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}
}
myplot(data = penguins, x = body_mass_g, y = bill_length_mm) #error
myplot(x = body_mass_g, y = flipper_length_mm) # with lines

myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE)

#layer plot
myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")

# = to any argument creates a default
# pull column frame from dataframe: use curly -curly {{}} to look into dataframe & assign

#make an "if" statement

a <- 4 
b <- 5

if (a > b) { #questopm
  f <- 20 #if true, give answer 1
  } else {  #else give answer 2
  f <- 10 
} 
f #gets answer 10

#Awesome R Package 

devtools::install_github("itsrainingdata/emokid")
library(emokid)
iamsad() # v sad
iamlesssad()
mymood() #emoji mood

