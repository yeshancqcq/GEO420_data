library(astrochron)
library(ggplot2)

#Read the SVZ data
svz_data = read()

#Construct a new data frame
svz = data.frame(YearsBP = svz_data$years)

#Initiating a blank column for the linear probability curve
svz$Linear_Prob <- NA

# Calculate the probability of keeping the record for each record in the dataset (linear through time)
# Assuming that at 30000 years bp, only 25% of the records are preserved, and
# at o years bp, 100% of the records are preserved
# To normalize the biased dataset:
# 1) We 100% keep records at 30000 years bp, and
# 2) We assign a 25% possibility that the record at 0 years bp would be kept, and
# 3) For every record in between, the possibility of being-kept is calculated from a linear curve 
# Thus:
# A linear normalization curve y = kx + b passes through (30000, 1) and (0, 0.25)
# So the equation of this curve is: y = 0.000025x + 0.25 where y is the possibility for keeping a record and x is the years bp

total_record <- nrow(svz)
for(i in 1:total_record){
  svz$Linear_Prob[i] <- 0.000025 * svz$YearsBP[i] + 0.25
}

# Let's do the Monte Carlo Simulation for the data normalization for 1000 times

for (mc in 1:1000){
  # Add a new column corresponding to the # of simulation
  svz$nextrun <-NA
  # Keep or drop for each record
  for (j in 1:total_record){
    # get a random number between 0 and 1
    random <- runif(1)
    # if the random number >= the probability, the record will be dropped as 0, otherwise, the record will be kept
    if (random >= svz$Linear_Prob[j]){
      svz$nextrun[j] <- 0
    } else {
      svz$nextrun[j] <- svz$YearsBP[j]
    }
  }
  # Change the column name to the number of this simulation
  names(svz)[mc+2] <- paste("Simu",toString(mc), sep = " ", collapse = NULL)
}

#====Ignore this block for now because it is only mathematically right but is meaningless=======

# next, sum each row from column 3 to column 1002 (all simulations)
svz$sum <- NA
for(i in 1:total_record){
  sum_this <- 0
  for (j in 3:1002){
    sum_this <- sum_this + svz[i,j]
    svz$sum[i] <- sum_this
  }
}

svz$normalized <- NA
for(i in 1:total_record){
  svz$normalized[i] <- svz$sum[i]/1000
}

# =======End of the meaningless block==========


# Plot the monte carlo results
plot <- ggplot()
for(i in 3:1002){
  gg.data <- data.frame(Time=svz[,i])
  plot<- plot+
    geom_freqpoly(data=gg.data, aes(x=Time), bins=30, colour="#A67C94", alpha = 0.05) 
}

plot <- plot + scale_x_reverse(limits = c(30000, 0.1)) +
  ggtitle("Number of SVZ Events Over Time","Monte Carlo Simulation for 1000 Times, Normalized to 30000 Years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(plot)





