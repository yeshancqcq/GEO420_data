library(astrochron)
library(ggplot2)
library(grid)
library(dplyr)

ka_temp=read()
ka_sp=spline(ka_temp$YearsBP, ka_temp$Kamchatka,n=500)
ka_temp_data = data.frame(Time=ka_sp$x, Temperature=ka_sp$y)

andes_temp = read()
andes_sp=spline(andes_temp$YearsBP, andes_temp$Andes, n=500)
andes_temp_data = data.frame(Time=andes_sp$x, AndesTemp = andes_sp$y)

nz_temp = read()
nz_sp=spline(nz_temp$YearsBP, nz_temp$New_Zealand, n=500)
nz_temp_data = data.frame(Time=nz_sp$x, NZTemp = nz_sp$y)

ka_vol=read()
ka_vol_data = data.frame(Events=ka_vol$BP)

andes_vol = read()
andes_vol_data = data.frame(AndesEvents = andes_vol$BP)

nz_vol = read()
nz_vol_data = data.frame(NZEvents = nz_vol$BP)

p_andes_kam <- ggplot() +  
  geom_freqpoly(data=ka_vol_data, aes(x=Events), bins=30, colour="#A67C94", alpha = 0.4)+
  #geom_histogram(data=ka_vol_data, aes(x=Events), binwidth = 1000, colour="#A67C94", alpha = 0.4)+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="red")+
  geom_line(data=ka_temp_data,aes(Time,(Temperature+8)*3.2), size = 0.5, colour = "#7CA0A6")+
  geom_line(data=andes_temp_data,aes(Time,(AndesTemp+8)*3.2), size = 0.5, colour = "blue")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 35), 
                     sec.axis = sec_axis(~./3.2-8, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic Records at Andes and Kamchatka", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  annotate("text", x = 23000, y = 29, label = "Volcanic Events at Kamchatka", size = 2.5, colour = "#A67C94") +
  annotate("text", x = 23000, y = 30, label = "Volcanic Events at Andes", size = 2.5 ,colour = "red") +
  annotate("text", x = 23000, y = 31, label = "Temperature Anomaly at Japan", size = 2.5, colour = "#7CA0A6") +
  annotate("text", x = 23000, y = 32, label = "Temperature Anomaly at Andes", size = 2.5 ,colour = "blue") +
  xlim(0, 30000)

p_andes_kam

p_andes_nz <- ggplot() +  
  geom_freqpoly(data=nz_vol_data, aes(x=NZEvents), bins=30, colour="#A67C94", alpha = 0.4)+
  #geom_histogram(data=ka_vol_data, aes(x=Events), binwidth = 1000, colour="#A67C94", alpha = 0.4)+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="red")+
  geom_line(data=nz_temp_data,aes(Time,(NZTemp+8)*3.2), size = 0.5, colour = "#7CA0A6")+
  geom_line(data=andes_temp_data,aes(Time,(AndesTemp+8)*3.2), size = 0.5, colour = "blue")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 35), 
                     sec.axis = sec_axis(~./3.2-8, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic Records at Andes and New Zealand", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  annotate("text", x = 23000, y = 29, label = "Volcanic Events at New Zealand", size = 2.5, colour = "#A67C94") +
  annotate("text", x = 23000, y = 30, label = "Volcanic Events at Andes", size = 2.5 ,colour = "red") +
  annotate("text", x = 23000, y = 31, label = "Temperature Anomaly at New Zealand", size = 2.5, colour = "#7CA0A6") +
  annotate("text", x = 23000, y = 32, label = "Temperature Anomaly at Andes", size = 2.5 ,colour = "blue") +
  xlim(0, 30000)

p_andes_nz
