## Today we will be practicing RMarkdown 
## Created by: Chloe Mintlow
## Updated on: 2023-02-28

#title: "My Markdown File" title = title of markdown document
#output: html_document output = format that it's saved as
#YAML = language used for markdown aka "yet another markup language"

install.packages("rmarkdown")
install.packages('tinytex') #good for creating pdf document
#start new RMarkdown document: File --> New File --> R Markdown --> Type in title  & Author --> save as HTML (or PDF) --> Knit: to create html document (opens new window)
#code chunk: 
library(tidyverse)
install.packages("beepr")
library(beepr)
beep(8)
beep(5)
?beep
beep(10)
beep(85)
