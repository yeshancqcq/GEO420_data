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

ant_temp = read()
ant_sp=spline(ant_temp$YearsBP, ant_temp$Antarctica, n=500)
ant_temp_data = data.frame(Time=ant_sp$x, AntTemp = ant_sp$y)

ka_vol=read()
ka_vol_data = data.frame(Events=ka_vol$BP)

andes_vol = read()
andes_vol_data = data.frame(AndesEvents = andes_vol$BP)

nz_vol = read()
nz_vol_data = data.frame(NZEvents = nz_vol$BP)

global_vol = read()
global_vol_data = data.frame(globalEvents = global_vol$BP)

global_glacier_vol = read()
global_glacier_vol_data = data.frame(globalGlacierEvents = global_glacier_vol$BP)

global_nonGlacier_vol = read()
global_nonGlacier_vol_data = data.frame(globalNonGlacierEvents = global_nonGlacier_vol$BP)

p_andes_kam <- ggplot() +  
  geom_freqpoly(data=ka_vol_data, aes(x=Events), bins=30, colour="#A67C94", alpha = 0.4)+
  #geom_histogram(data=ka_vol_data, aes(x=Events), binwidth = 1000, colour="#A67C94", alpha = 0.4)+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="red")+
  geom_line(data=ka_temp_data,aes(Time,(Temperature+9)*3), size = 0.5, colour = "#7CA0A6")+
  geom_line(data=andes_temp_data,aes(Time,(AndesTemp+9)*3), size = 0.5, colour = "blue")+
  geom_line(data=ant_temp_data,aes(Time,(AntTemp+9)*3), size = 0.5, colour = "black")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 35), 
                     sec.axis = sec_axis(~./3-9, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic Records at Andes and Kamchatka", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  annotate("text", x = 23000, y = 29, label = "Volcanic Events at Kamchatka", size = 2.5, colour = "#A67C94") +
  annotate("text", x = 23000, y = 30, label = "Volcanic Events at Andes", size = 2.5 ,colour = "red") +
  annotate("text", x = 23000, y = 31, label = "Temperature Anomaly at Antarctica", size = 2.5 ,colour = "black") +
  annotate("text", x = 23000, y = 32, label = "Temperature Anomaly at Japan", size = 2.5, colour = "#7CA0A6") +
  annotate("text", x = 23000, y = 33, label = "Temperature Anomaly at Andes", size = 2.5 ,colour = "blue") +
  scale_x_reverse(limits = c(30000, 0))

p_andes_kam

p_andes_nz <- ggplot() +  
  geom_freqpoly(data=nz_vol_data, aes(x=NZEvents), bins=30, colour="#A67C94", alpha = 0.4)+
  #geom_histogram(data=ka_vol_data, aes(x=Events), binwidth = 1000, colour="#A67C94", alpha = 0.4)+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="red")+
  geom_line(data=nz_temp_data,aes(Time,(NZTemp+8)*3.2), size = 0.5, colour = "#7CA0A6")+
  geom_line(data=ant_temp_data,aes(Time,(AntTemp+9)*3), size = 0.5, colour = "black")+
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
  annotate("text", x = 23000, y = 31, label = "Temperature Anomaly at Antarctica", size = 2.5 ,colour = "black") +
  annotate("text", x = 23000, y = 32, label = "Temperature Anomaly at New Zealand", size = 2.5, colour = "#7CA0A6") +
  annotate("text", x = 23000, y = 33, label = "Temperature Anomaly at Andes", size = 2.5 ,colour = "blue") +
  scale_x_reverse(limits = c(30000, 0))
p_andes_nz

p_kam_histo <- ggplot()+
  geom_histogram(data=ka_vol_data, aes(x=Events), binwidth = 1000, colour="#A67C94",alpha = 0.2)+
  geom_line(data=ka_temp_data,aes(Time,(Temperature+3.2)*3), size = 1, colour = "#7CA0A6")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 17), 
                     sec.axis = sec_axis(~./3-3.2, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic and Temperature Records at Kamchatka", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  scale_x_reverse(limits = c(30000, 0))+
  annotate("text", x = 23000, y = 14, label = "Volcanic Events at Kamchatka", size = 2.8, colour = "#A67C94")+
  annotate("text", x = 23000, y = 15, label = "Temperature Anomaly at Japan", size = 2.8, colour = "#7CA0A6")
p_kam_histo

p_nz_histo <- ggplot()+
  geom_histogram(data=nz_vol_data, aes(x=NZEvents), binwidth = 1000, colour="#A67C94",alpha = 0.2)+
  geom_line(data=nz_temp_data,aes(Time,(NZTemp+6)*2.4), size = 1, colour = "#7CA0A6")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 17), 
                     sec.axis = sec_axis(~./2.4-6, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic and Temperature Records at New Zealand", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  scale_x_reverse(limits = c(30000, 0))+
  annotate("text", x = 23000, y = 14, label = "Volcanic Events at New Zealand", size = 2.8, colour = "#A67C94")+
  annotate("text", x = 23000, y = 15, label = "Temperature Anomaly at New Zealad", size = 2.8, colour = "#7CA0A6")
p_nz_histo

p_andes_histo <- ggplot()+
  geom_histogram(data=andes_vol_data, aes(x=AndesEvents), binwidth = 1000, colour="#A67C94",alpha = 0.2)+
  geom_line(data=andes_temp_data,aes(Time,(AndesTemp+6)*3), size = 1, colour = "#7CA0A6")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 30), 
                     sec.axis = sec_axis(~./3-6, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic and Temperature Records at Andes", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  scale_x_reverse(limits = c(30000, 0))+
  annotate("text", x = 23000, y = 29, label = "Volcanic Events at Andes", size = 2.8, colour = "#A67C94")+
  annotate("text", x = 23000, y = 30, label = "Temperature Anomaly at Andes", size = 2.8, colour = "#7CA0A6")
p_andes_histo

p_global <- ggplot()+
  geom_line(data=andes_temp_data,aes(Time,(AndesTemp+9)*13), size = 0.5, colour = "#7CA0A6")+
  geom_line(data=ka_temp_data,aes(Time,(Temperature+9)*13), size = 0.5, colour = "orange", alpha = 0.5)+
  geom_line(data=nz_temp_data,aes(Time,(NZTemp+9)*13), size = 0.5, colour = "purple")+
  geom_line(data=ant_temp_data,aes(Time,(AntTemp+9)*13), size = 0.5, colour = "light blue")+
  geom_freqpoly(data=global_vol_data, aes(x=globalEvents), bins=30, colour="black", alpha = 1)+
  geom_freqpoly(data=global_glacier_vol_data, aes(x=globalGlacierEvents), bins=30, colour="red", alpha = 1)+
  geom_freqpoly(data=global_nonGlacier_vol_data, aes(x=globalNonGlacierEvents), bins=30, colour="blue", alpha = 1)+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 150), 
                     sec.axis = sec_axis(~./13-9, name = "Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Global Volcanic and Temperature Records", "with records of temperature anomalies regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  scale_x_reverse(limits = c(30000, 0))+
  annotate("text", x = 23000, y = 115, label = "Global volcanic events", size = 2.8, colour = "black")+
  annotate("text", x = 23000, y = 120, label = "Volcanic events in glacial regions", size = 2.8, colour = "red")+
  annotate("text", x = 23000, y = 125, label = "Volcanic events in nonglacial regions", size = 2.8, colour = "blue")+
  annotate("text", x = 23000, y = 130, label = "Temperature anomaly at Kamchatka", size = 2.8, colour = "orange", alpha = 0.5)+
  annotate("text", x = 23000, y = 135, label = "Temperature anomaly at Andes", size = 2.8, colour = "#7CA0A6")+
  annotate("text", x = 23000, y = 140, label = "Temperature anomaly at New Zealand", size = 2.8, colour = "purple")+
  annotate("text", x = 23000, y = 145, label = "Temperature anomaly at Antarctica", size = 2.8, colour = "light blue")
p_global

