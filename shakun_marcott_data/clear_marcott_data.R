library(astrochron)
library(readr)
library(dplyr)

clear_marcott_data <- function (input){
  
  #Convert the csv into a data frame that contains the age in the first 
  #column and temperature iin the second column
  df=data.frame(input[5],input[6])
  
  #Rename columns
  names(df) <- c("Published.age", "Published.temperature")
  
  #Add counter to indicate empty rows for ages
  counter <- vector()
  
  #Loop to find empty rows for ages
  for(i in 1:nrow(df)){
    if(is.na(df$Published.age[i])){
      counter <- c(counter, i)
    }
  }
  
  #Delete empty rows for ages
  df2 <- df[-counter,]
  
  #Add counter to indicate empty rows for temperature
  counterTemp <- vector()
  
  #Loop to find empty rows for temperature
  for(i in 1:nrow(df2)){
    if(is.na(df2$Published.temperature[i])){
      counterTemp <- c(counterTemp, i)
    }
  }
  
  #Delete empty rows for ages
  df3 <- df2[-counterTemp,]
  
  #Cut the unit row
  df4 <- df3 %>% slice(2:nrow(df3))
  
  return(df4)
}
