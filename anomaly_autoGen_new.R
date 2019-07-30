library(plyr)
library(astrochron)

files <- list.files(path="/Users/yeshan/Documents/github/GEO420_data/cleared_data", 
                    pattern="*.csv", full.names=TRUE, recursive=FALSE)


lapply(files, function(x) {
  dt <- read.csv(x, skip=0)
  filename <- basename(x)
  
  cat("processing", filename)
  
  start_age = dt$age[1]
  
  # Getting the next 100 year point prior to the latest age
  start_num = round_any(start_age, 100, f = ceiling) 
  
  # Doing the linear interpolation with 100-yr steps
  # Starting at the next 100 year point prior to the latest age
  dt_int=linterp(dt, dt=100, start=start_num, genplot=F)
  
  # get the average between 8000 and 12000 bp as reference (anomaly base) 
  anomaly_base = NA
  counter <- 0
  sumRange <- 0
  
  for (i in 1:nrow(dt_int)){
    if(dt_int$age[i]>=8000 && dt_int$age[i]<= 12000){
      if(dt_int$temp[i]!=0){
        sumRange <- sumRange + dt_int$temp[i]
        counter <- counter + 1
      }
    }
  }
  
  # if there are more than 10 data points within the 8000-12000 bp range, we regard it a valid case for generating the anomaly base
  if(counter >= 10){
    anomaly_base <- sumRange/counter
  } else {
    anomaly_base = NA
  }
  
  # initiating 2 vectors, one for temperature anomaly, one for abandoned 
  # files (those without data at 10000 years bp)
  abandoned_files <- vector()
  temp_anomaly <- vector()
  
  # Check if it has data for anomaly years bp
  # if yes: generate the anomaly vector
  # if no: print the filename and add it to the abandoned files
  if (is.na(anomaly_base)){
    cat(filename," does not contain the anomaly standard.")
    abandoned_files <- c(abandoned_files, filename)
  } else {
    for(j in 1:nrow(dt_int)){
      anomaly <- dt_int$temp[j]-anomaly_base
      temp_anomaly <- c(temp_anomaly, anomaly)
    }
    # Generating the new data frame with age, temp and anomaly columns
    dt_df <- data.frame(Age=dt_int$age, Temperature=dt_int$temp, Anomaly=temp_anomaly)
    
    # Writing the csv
    write.csv(dt_df, paste0("/Users/yeshan/Documents/github/GEO420_data/anomaly_int_data_new/anomaly_", filename), row.names=F)
  }
})
