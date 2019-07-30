library(readr)
library(ggplot2)

metadata <- read_csv("Anomaly_metadata_new.csv")
coverage <- data.frame(ID=metadata$ID, Lat=metadata$Latitude, Lon=metadata$Longitude)
for(i in 0:220){
  coverage$new <- NA
  for(j in 1:nrow(coverage)){
    lat <- coverage$Lat[j]
    if(is.na(metadata[j, i+13])){
      coverage$new[j] <- NA
    } else {
      coverage$new[j] <- lat
    }
  }
  colnames(coverage)[4+i] <- toString(i)
}

for (i in 4:224){
  k=153
  coverage[k,i]=i-4
}


output <- coverage
output <- output[,-1]
output <- output[,-1]
output <- output[,-1]

output<- as.data.frame(t(output))

anomaly_min <- data.frame(xmin = 98, xmax = 105, ymin = -Inf, ymax = Inf)
anomaly_max <- data.frame(xmin = 83, xmax = 120, ymin = -Inf, ymax = Inf)

plot <- ggplot()
for(i in 1:151){
  gg.data <- data.frame( Time=output[,153], Lat=output[,i])
  plot<- plot+
    geom_line(data=gg.data, aes(x=(0:220), y=Lat),size = 1, colour="#cfcdc8", alpha = 1) 
}

plot <- plot + scale_x_reverse(limits = c(220, 0),breaks = scales::pretty_breaks(n = 9)) +
  ggtitle("Spatiotemporal coverage of paleoclimate data", "with potential periods for anomaly calculation") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_y_continuous(name = expression("Latitude"), limits = c(-90,90), breaks = scales::pretty_breaks(n = 9))+
  labs(y = "Counts",
       x = "Time (Hundred years bp)",
       colour = "Parameter")+
  geom_rect(data=anomaly_min, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="blue", alpha=0.1, inherit.aes = FALSE)+
  geom_rect(data=anomaly_max, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="red", alpha=0.05, inherit.aes = FALSE)
print(plot)