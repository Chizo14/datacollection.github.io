## Workshop: Scraping webpages with R rvest package
# Prerequisites: Chrome browser, Selector Gadget

install.packages("tidyverse")
library(tidyverse)
install.packages("rvest")
library(rvest)

url <- 'https://en.wikipedia.org/wiki/List_of_countries_by_foreign-exchange_reserves'
#Reading the HTML code from the Wiki website
class(url)
wikiforreserve <- read_html(url)
class(wikiforreserve)

## Get the XPath data using Inspect element feature in Safari, Chrome or Firefox
## At Inspect tab, look for <table class=....> tag. Leave the table close
## Right click the table and Copy --> XPath, paste at html_nodes(xpath =)

foreignreserve <- wikiforreserve %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div[1]/table[1]') %>%
  html_table()
class(foreignreserve) # Why the first column is not scrapped?

fores = foreignreserve[[1]][,c(1, 2,3,4,5,6,7) ] # [[ ]] returns a single element directly, without retaining the list structure.


# 
names(fores) <- c("Country", "Forexreswithgold", "Date1", "Change1","Forexreswithoutgold", "Date2","Change2", "Sources")
colnames(fores)

head(fores$Country, n=10)
class(fores$Date1)
# Sources column useful?

## Clean up variables
## What type is Date?

# Convert Date1 variable
fores$Date1 = as.Date(fores$Date1, format = "%d %b %Y")
class(fores$Date1)

write.csv(fores, "fores.csv", row.names = FALSE) # use fwrite?




