library(astrochron)
library(ggplot2)
library(grid)
library(dplyr)

#import datasets

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

alaska_vol=read()
alaska_vol_data = data.frame(Events=alaska_vol$BP)

cwus_vol=read()
cwus_vol_data = data.frame(Events=cwus_vol$BP)

sa_vol=read()
sa_vol_data = data.frame(Events=sa_vol$BP)

andes_vol = read()
andes_vol_data = data.frame(AndesEvents = andes_vol$BP)

nz_vol = read()
nz_vol_data = data.frame(NZEvents = nz_vol$BP)

andes_noCa = read()
andes_noCa_data = data.frame(noCa_Events = andes_noCa$BP)

andes_noHu = read()
andes_noHu_data = data.frame(noHu_Events = andes_noHu$BP)

andes_noMc = read()
andes_noMc_data = data.frame(noMc_Events = andes_noMc$BP)

andes_noOs = read()
andes_noOs_data = data.frame(noOs_Events = andes_noOs$BP)

andes_noPc = read()
andes_noPc_data = data.frame(noPc_Events = andes_noPc$BP)

andes_noVr = read()
andes_noVr_data = data.frame(noVr_Events = andes_noVr$BP)

glacier_west_us = read()
glacier_west_us_data = data.frame(Age = glacier_west_us$Age, Length = glacier_west_us$Length)

glacier_nz_aus = read()
glacier_nz_aus_data = data.frame(Age = glacier_nz_aus$Age, Length = glacier_nz_aus$Length)

all_glacier = read()
all_glacier_data = data.frame(Age = all_glacier$Age, Length = all_glacier$Length, Location = all_glacier$Location)

global_vol =read()
global_vol_data=data.frame(Event=global_vol$BP)

global_g_vol =read()
global_g_vol_data=data.frame(Event=global_g_vol$BP)

global_ng_vol =read()
global_ng_vol_data=data.frame(Event=global_ng_vol$BP)

#old plots

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

# figure 1:

p_all_temp <- ggplot()+
  geom_line(data=ka_temp_data,aes(Time,Temperature), size = 0.5, colour = "#7CA0A6")+
  geom_line(data=andes_temp_data,aes(Time,AndesTemp), size = 0.5, colour = "blue", alpha = 0.5)+
  geom_line(data=ant_temp_data,aes(Time,AntTemp), size = 0.5, colour = "black")+
  geom_line(data=nz_temp_data,aes(Time,NZTemp), size = 0.5, colour = "red", alpha = 0.5)+
  scale_y_continuous(name = expression("Temperature Anomaly (°C)"), limits = c(-10, 6))+
  labs(y = "Counts",
       x = "Time (Years BP)") +
  ggtitle("(a) Temperature Anomalies", "regarding 10,000 years BP") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line.y = element_line(colour = "black"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_text(size=7)
        ) +
  scale_x_reverse(limits = c(30000, 0))+
  annotate("text", x = 25000, y = 5, label = "Andes", size = 2.8, colour = "blue", alpha = 0.5)+
  annotate("text", x = 25000, y = 4, label = "Antarctica", size = 2.8, colour = "black")+
  annotate("text", x = 25000, y = 3, label = "Japan", size = 2.8, colour = "#7CA0A6")+
  annotate("text", x = 25000, y = 2, label = "New Zealand", size = 2.8, colour = "red", alpha = 0.5)
p_all_temp

p_ngl <- ggplot(all_glacier_data, aes(x=Age, y=Length, color=Location, shape=Location)) +
  geom_point()+
  scale_y_continuous(name = expression("Normolized Glacier Lengths"), limits = c(0, 1))+
  labs(y = "Counts",
       x = "Time (Years BP)") +
  ggtitle("(b) Normolized Glacier Lengths") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line.y = element_line(colour = "black"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_text(size=7),
        legend.justification = c(0, 0),
        legend.position = c(0.1, 0.1),
        legend.background = element_rect(colour = "black"),
        legend.key = element_rect(colour = "white", fill = NA),
        legend.title = element_blank(),
        legend.text=element_text(size=rel(0.63))
  ) + 
  geom_smooth(method=lm,  linetype="dashed", size=0.4, se=FALSE)+
  scale_x_reverse(limits = c(30000, 0))+
  scale_shape_manual(values=c(16, 4))+ 
  scale_size_manual(values=c(5,5))+
  scale_color_manual(values=c('red','black'))
p_ngl  

p_global_vol <- ggplot()+
  geom_freqpoly(data=global_vol_data, aes(x=Event), bins=30, colour="black")+
  geom_freqpoly(data=global_g_vol_data, aes(x=Event), bins=30, colour="blue")+
  geom_freqpoly(data=global_ng_vol_data, aes(x=Event), bins=30, colour="red")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 155))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("(c) Global volcanic records") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line.y = element_line(colour = "black"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_text(size=7)
        ) +
  annotate("text", x = 25000, y = 150, label = "All records", size = 2.5, colour = "black") +
  annotate("text", x = 25000, y = 140, label = "Regions with glaciation", size = 2.5 ,colour = "blue") +
  annotate("text", x = 25000, y = 130, label = "Regions without glaciation", size = 2.5 ,colour = "red") +
  scale_x_reverse(limits = c(30000, 0))
p_global_vol

p_location_vol <- ggplot()+
  geom_freqpoly(data=ka_vol_data, aes(x=Events), bins=30, colour="#4282af")+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="black")+
  geom_freqpoly(data=nz_vol_data, aes(x=NZEvents), bins=30, colour="red", alpha = 0.6)+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 50))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("(d) Volcanic records","Andes, Kamchatca and New Zealand") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        axis.title.y=element_text(size=7),
        axis.title.x=element_text(size=7)
  ) +
  annotate("text", x = 25000, y = 49, label = "Andes", size = 2.5, colour = "black") +
  annotate("text", x = 25000, y = 46, label = "Kamchatca", size = 2.5 ,colour = "#4282af") +
  annotate("text", x = 25000, y = 43, label = "New Zealand", size = 2.5 ,colour="red", alpha = 0.68) +
  scale_x_reverse(limits = c(30000, 0), breaks = scales::pretty_breaks(n = 20))
p_location_vol

library(gtable)
g2 <- ggplotGrob(p_all_temp)
g3 <- ggplotGrob(p_ngl)
g4 <- ggplotGrob(p_global_vol)
g5 <- ggplotGrob(p_location_vol)
g <- rbind(g2, g3, g4, g5, size = "first")
g$widths <- unit.pmax(g2$widths, g3$widths, g4$widths, g5$widths)
grid.newpage()
grid.draw(g)

# figure 2
p_vol_agg <- ggplot()+
  geom_freqpoly(data=ka_vol_data, aes(x=Events), bins=30, colour="dark green")+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="black")+
  geom_freqpoly(data=nz_vol_data, aes(x=NZEvents), bins=30, colour="red", alpha = 0.6)+
  geom_freqpoly(data=alaska_vol_data, aes(x=Events), bins=30, colour="orange", alpha = 0.6)+
  geom_freqpoly(data=sa_vol_data, aes(x=Events), bins=30, colour="purple", alpha = 0.6)+
  geom_freqpoly(data=cwus_vol_data, aes(x=Events), bins=30, colour="blue", alpha = 0.6)+
  geom_line(data=ant_temp_data,aes(Time,(AntTemp+15)*2.4), size = 0.5, colour = "#28339b")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 45), 
                     sec.axis = sec_axis(~./2.4-15, name = "Antarctica Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic records at Various Locations","with temperature anomalies at Antarctica") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line.x = element_line(colour = "black"),
        axis.title.y=element_text(size=10),
        axis.line.y.left = element_line(colour = "black"),
        axis.line.y.right = element_line(colour = "#28339b"),
        axis.title.x=element_text(size=10),
        axis.title.y.right = element_text(colour = "#28339b"),
        axis.text.y.right = element_text(colour = "#28339b"),
        axis.ticks.y.right = element_line(colour = "#28339b")
  ) +
  annotate("text", x = 25000, y = 44, label = "UWis-Madison Andes Data", size = 3, colour = "black") +
  annotate("text", x = 25000, y = 42, label = "Kamchatca", size = 3 ,colour = "dark green") +
  annotate("text", x = 25000, y = 40, label = "New Zealand", size = 3,colour="red", alpha = 0.68) +
  annotate("text", x = 25000, y = 38, label = "Alaska", size = 3 ,colour="orange", alpha = 0.6)+
  annotate("text", x = 25000, y = 36, label = "Canada and Western US", size = 3 ,colour="blue", alpha = 0.6)+
  annotate("text", x = 25000, y = 34, label = "South America", size = 3 ,colour="purple", alpha = 0.6)+
  annotate("text", x = 6000, y = 39, label = "Antarctica Temperature Anomaly", size = 3, colour = "#28339b")+
  scale_x_reverse(limits = c(30000, 0), breaks = scales::pretty_breaks(n = 20))
p_vol_agg

# figure 3
p_andes_leave_out <- ggplot()+
  geom_freqpoly(data=andes_vol_data, aes(x=AndesEvents), bins=30, colour="black")+
  geom_freqpoly(data=andes_noCa_data, aes(x=noCa_Events), bins=30, colour="blue")+
  geom_freqpoly(data=andes_noHu_data, aes(x=noHu_Events), bins=30, colour="pink")+
  geom_freqpoly(data=andes_noMc_data, aes(x=noMc_Events), bins=30, colour="dark green")+
  geom_freqpoly(data=andes_noVr_data, aes(x=noVr_Events), bins=30, colour="red")+
  geom_freqpoly(data=andes_noOs_data, aes(x=noOs_Events), bins=30, colour="purple")+
  geom_freqpoly(data=andes_noPc_data, aes(x=noPc_Events), bins=30, colour="orange", alpha = 0.66)+
  geom_line(data=ant_temp_data,aes(Time,(AntTemp+15)*2.4), size = 0.5, colour = "#28339b")+
  scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 45), 
                     sec.axis = sec_axis(~./2.4-15, name = "Antarctica Temperature Anomaly (°C)"))+
  labs(y = "Counts",
       x = "Time (Years BP)",
       colour = "Parameter") +
  ggtitle("Volcanic records at Andes","with single volcano left-out") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line.x = element_line(colour = "black"),
        axis.title.y=element_text(size=10),
        axis.line.y.left = element_line(colour = "black"),
        axis.line.y.right = element_line(colour = "#28339b"),
        axis.title.x=element_text(size=10),
        axis.title.y.right = element_text(colour = "#28339b"),
        axis.text.y.right = element_text(colour = "#28339b"),
        axis.ticks.y.right = element_line(colour = "#28339b")
  ) +
  annotate("text", x = 25000, y = 44, label = "UWis-Madison Andes Data", size = 3, colour = "black") +
  annotate("text", x = 25000, y = 42, label = "leave out Calbuco", size = 3 ,colour = "blue") +
  annotate("text", x = 25000, y = 40, label = "leave out Hudson", size = 3,colour="pink") +
  annotate("text", x = 25000, y = 38, label = "leave out Mocho Choshuenco", size = 3 ,colour="dark green")+
  annotate("text", x = 25000, y = 36, label = "leave out Osorno", size = 3 ,colour="purple")+
  annotate("text", x = 25000, y = 34, label = "leave out Puyehue Cordon Caulle", size = 3 ,colour="orange")+
  annotate("text", x = 25000, y = 32, label = "leave out Villarrica", size = 3 ,colour="red")+
  annotate("text", x = 6000, y = 39, label = "Antarctica Temperature Anomaly", size = 3, colour = "#28339b")+
  scale_x_reverse(limits = c(30000, 0), breaks = scales::pretty_breaks(n = 20))
p_andes_leave_out
