library(astrochron)
library(plyr)

# Reading the data and filename
filename <- file.choose()
dt <- read.csv(filename, skip=0)
filename <- basename(filename)

# Checking the latest age in the dataset
start_age = dt$age[1]

# Getting the next 100 year point prior to the latest age
start_num = round_any(start_age, 100, f = ceiling) 

# Doing the linear interpolation with 100-yr steps
# Starting at the next 100 year point prior to the latest age
dt_int=linterp(dt, dt=100, start=start_num, genplot=F)

#get the 10000 bp row number as reference (anomaly base)
anomaly_base = NA
for (i in 1:nrow(dt_int)){
  if(dt_int$age[i]==10000){
    anomaly_base <- dt_int$temp[i]
  }
}

# initiating 2 vectors, one for temperature anomaly, one for abandoned 
# files (those without data at 10000 years bp)
abandoned_files <- vector()
temp_anomaly <- vector()

# Check if it has data at 10000 years bp
# if yes: generate the anomaly vector
# if no: print the filename and add it to the abandoned files
if (is.na(anomaly_base)){
  cat(filename," does not contain the anomaly standard.")
  abandoned_files <- c(abandoned_files, filename)
} else {
  for(j in 1:nrow(dt_int)){
    anomaly <- dt_int$temp[j]-anomaly_base
    temp_anomaly <- c(temp_anomaly, anomaly)
    # Generating the new data frame with age, temp and anomaly columns
    dt_df <- data.frame(Age=dt_int$age, Temperature=dt_int$temp, Anomaly=temp_anomaly)
    
    # Writing the csv
    write.csv(dt_df, paste0("/Users/apple/Documents/moving_ave/anomaly/anomaly_", filename), row.names=F)
  }
}




