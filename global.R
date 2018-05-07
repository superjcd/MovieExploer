library(dplyr)
library(shiny)
library(shinythemes)
library(lubridate)
library(DT)
library(shinyjs)
library(plotly)
library(tidyr)
library(purrr)
library(broom)
##shiny options
options(shiny.reactlog = T) #usage:showReactiveLog
options(shiny.browser = T)

#load data
movies <- readRDS('data/movies.rds')
movies$`总票房（万）` <- as.numeric(movies$`总票房（万）`)
movies$豆瓣评分 <- as.numeric(movies$豆瓣评分)

#select input data
area <- as.character(unique(movies$地区))
genre <- as.character(unique(movies$主类型))
daterange <- range(ymd(movies$上映日期))

##judge function
#jude area
if_area <- function(Input) {
  if (Input == '全部') {
    area
  }
  else{
    Input
  }
}

#judge genre
if_genre <- function(Input) {
  if (Input == '全部') {
    genre
  }
  else{
    Input
  }
}

#download handler
download_csv<-function(data,label){downloadHandler(
  filename = function() {
    paste(label, Sys.Date(), '.csv', sep='')
  },
  content = function(file) {
    write.csv(data, file, row.names = FALSE)
  }
)
}
