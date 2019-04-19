library(astrochron)
library(ggplot2)
library(grid)
library(dplyr)

japan=read()
japan_sp=spline(japan$BP, japan$NW.Pacific,n=1000)

andes=read()
andes_sp=spline(andes$BP, andes$South.America, n=1000)

nz=read()
nz_sp=spline(nz$BP, nz$New.Zealand, n=1000)

global = read()

plot_temp = nz_sp
temp_data <- data.frame(Time=plot_temp$x, Temperature=plot_temp$y)

KA_vol = read()
andes_vol = read()
nz_vol = read()

vol_plot=nz_vol
vol_data = data.frame(Events=vol_plot$bp)

ggplot() +  
  geom_line(data=temp_data,aes(Time,Temperature), size = 1, colour = "#7CA0A6")+
  geom_histogram(data=vol_data, aes(x=Events), binwidth=500, colour="black", fill="#A67C94", alpha = 0.7)+
  scale_y_continuous(name = expression("Temperature ("~degree~"C)"), limits = c(0, 21), 
                     sec.axis = sec_axis(~.-0, name = "Count of volcanic events"))+
  labs(y = "Temperature [°C]",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("New Zealand Volcanic and Temperature Records", " ") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  annotate("text", x = 23580, y = 5, label = "Volcanic Events", colour = "#A67C94") +
  annotate("text", x = 23580, y = 19, label = "Temperature", colour = "#7CA0A6") +
  xlim(0, 30000)


