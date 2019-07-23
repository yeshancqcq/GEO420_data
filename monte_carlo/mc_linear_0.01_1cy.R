library(astrochron)
library(ggplot2)
library(readr)
setwd("~/GitHub/GEO420_data")

#Read the SVZ data
svz_data <-read_csv("volcano_data/svz.csv")

#Construct a new data frame
svz = data.frame(YearsBP = svz_data$years)

#Initiating a blank column for the linear probability curve
svz$Linear_Prob <- NA

# Calculate the probability of keeping the record for each record in the dataset (linear through time)
# Assuming that at 30000 years bp, only 10% of the records are preserved, and
# at o years bp, 100% of the records are preserved
# To normalize the biased dataset:
# 1) We 100% keep records at 30000 years bp, and
# 2) We assign a 1% possibility that the record at 0 years bp would be kept, and
# 3) For every record in between, the possibility of being-kept is calculated from a linear curve 
# Thus:
# A linear normalization curve y = kx + b passes through (30000, 1) and (0, 0.01)
# So the equation of this curve is: y = 0.003333x + 0.01 where y is the possibility for keeping a record and x is the years bp

total_record <- nrow(svz)
for(i in 1:total_record){
  svz$Linear_Prob[i] <- 0.003333 * svz$YearsBP[i] + 0.01
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

# Andes temperature data
andes_temp <- read_csv("img/andes_anomaly.csv")
andes_sp=spline(andes_temp$YearsBP, andes_temp$Andes, n=500)
andes_temp_data = data.frame(Time=andes_sp$x, AndesTemp = andes_sp$y)


# Plot the monte carlo results
plot <- ggplot()
for(i in 3:1002){
  gg.data <- data.frame(Time=svz[,i])
  plot<- plot+
    geom_freqpoly(data=gg.data, aes(x=Time), bins=30, size = 1.5, colour="#A67C94", alpha = 0.05) 
}

plot <- plot + scale_x_reverse(limits = c(30000, 0.1),breaks = scales::pretty_breaks(n = 20)) +
  ggtitle("Number of SVZ Events Over Time, Normalized to 30000 Years BP (Linear)","Monte Carlo Simulation for 1000 Times, Assume 10% Records Are Preserved at 30000 Years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(data=andes_temp_data,aes(Time,(AndesTemp+5.3)*3), size = 0.5, colour = "blue")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 25), 
                     sec.axis = sec_axis(~./3-5.3, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter")
print(plot)





