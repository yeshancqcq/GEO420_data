install.packages("rjson")
install.packages("jsonlite")
install.packages("R.utils")
library(rjson)

# Set up the working directory
setwd("/Users/apple/Desktop/GEO420_data") 
# Change to your working directory: the folder where the json file and scripts are saved

# Read the json file
glacier_raw_data <- fromJSON(file = "chile_ar_ar.bibjson")

# Sourcing self-developped functions in the same directory
# This step have to be done AFTER reading the json data, because the jsonToDF.R has a package that can overwrite some functions of rjson
source("jsonToDf.R")

# Using the jsonToDf function to convert json to data frame
glacier_data <- jsonToDf(glacier_raw_data)

# Writing a csv file (optional)
write.csv(glacier_data, "glacier_data.csv")


