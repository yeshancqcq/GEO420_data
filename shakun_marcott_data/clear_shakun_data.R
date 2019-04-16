library(astrochron)
library(readr)
library(dplyr)

clear_shakun_data <- function (input){
  #Convert the csv into a data frame that contains the age in the first 
  #column and temperature iin the second column
  df=data.frame(input$`Published age`,input$`Published temperature`)
  
  #Rename columns
  names(df) <- c("Published.age", "Published.temperature")
  
  df <- df %>% slice(2:nrow(df))
  
  return(df)
}

# So far, Shakun's data is much better organized than Marcott's data. If we find anything wrong when processing useful datasets 
# for moving average, we need to change this code.
