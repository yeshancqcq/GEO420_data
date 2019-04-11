%% Chile and LR04 Analysis
%% load data 
load('LR04.txt'); %Global Benthic d18O (Lisiecki and Raymo 2005)
load('edc_co2.txt') %EPICA DOME C CO2 (Monnin et al 2006)
load('kaiser_sst.txt') %70 ka SST record for ODP Site 202-1233 (Kaiser et al 2005)
load('chile_dates.txt'); %georoc + svz data from EM papers
load('chile_sio2.txt'); %georoc + svz data from EM papers 
%% Only look at last 30 ka
S=find(chile_dates<30); % only look at SVZ dates 30 ka to present 
chile_dates=chile_dates(S);
%% Andean Volcanic Events histogram 
figure(1)
histogram(chile_dates,30); % 1000 year bins 
set(gca,'XDir','reverse')
title('Andean Volcanic Events per 1 ka')
xlabel('age [ka]')
ylabel('count')
%% Calculate mean eruption rate per 1 ka over 0-5 ka
% [N,edges]=histcounts(chile_dates,30); %count histogram bin entries (30 bins = 1 per 1000 yrs)

%calculate mean per kyr eruption rate from 0-5 ka (Watt 2013 et al fig 10)
for i=1:4
    ka(i)=numel(find ((chile_dates>i)&(chile_dates<i+1)));
end
mean_ka_rate=mean(ka);

%% Normalize (# events per 1 ka normalized to 0-5 ka mean rate)
for i=1:29
    ka(i)=numel(find ((chile_dates>i)&(chile_dates<i+1)));
end
mean_ka_norm=ka./mean_ka_rate;

plot(mean_ka_norm)
set(gca,'XDir','reverse')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
title('Andean Eruption Rate')
%% LR04 and number of volcanic events 
holder=ones(size(chile_dates))*0.0001; %wtf is going on but it works (?)
holder=holder+4;
LRtime=LR04(1:31,1); % only look at LR04 from 30 ka to present 
O18=LR04(1:31,2);
figure(2)
plot(LRtime,O18)
hold on
scatter(chile_dates,holder)
set(gca,'XDir','reverse')
title ('Andean Volcanic Events and LR04')
xlabel('time [ka]')
ylabel('d18O [o/oo]')
hold off 
%% LR04 and Normalized Eruption Rate (per 1 ka)
figure(3)
yyaxis right 
plot(LRtime,O18);
ylabel ('dO18')
hold on
yyaxis left
plot(mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and LR04')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
%% Kaiser et al 2005 ODP SST and Normalized Eruption Rate (per 1 ka)
figure(4)
ksst=kaiser_sst(:,4);
ksst_age=edc_co2(:,2);
S=find(ksst_age<30); % only look at SVZ dates 30 ka to present 
ksst_age=ksst_age(S);
ksst=ksst(S);
yyaxis right 
plot(ksst_age,ksst);
ylabel (' ODP Site 202-1233 SST')
hold on
yyaxis left
plot(mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and ODP Site 202-1233 SST')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
%% EPICA Dome C CO2 and Normalized Eruption Rate (per 1 ka)
figure(5)
co2=edc_co2(:,3);
co2_age=edc_co2(:,2);
yyaxis right 
plot(co2_age,co2);
ylabel ('EPICA Dome C CO2')
hold on
yyaxis left
plot(mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and EPICA Dome C CO2')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
%% SiO2 content 
figure(6)
SiO2=chile_sio2(:,2);
Chile_SiTime=chile_sio2(:,1)
S2=find(Chile_SiTime<30); % only look at SVZ dates 30 ka to present 
SiO2=SiO2(S2);
Chile_SiTime=Chile_SiTime(S2);
scatter(Chile_SiTime,SiO2);
set(gca,'XDir','reverse')
title ('SiO2 through time')
ylabel ('SiO2')
xlabel('age[ka]')
%%
x=chile_sio2(:,1); %x is time
y=chile_sio2(:,2); %y is sio2 content
topEdge=30; %define limits
botEdge=0;%define limits
numBins=30; %one bin per 1 ka
binEdges=linspace(botEdge,topEdge,numBins+1);
[h,whichBin]=histc(x,binEdges);
binMean=zeros(1,numBins+1);
for i=1:numBins
    flagBinMembers=(whichBin==i); %which members are in bin? binary
    binMembers=y(flagBinMembers); %index into y 
    binMean(i)=nanmean(binMembers);
end
binMean(find(isnan(binMean)))=0;
%% Visualize LR04 and SiO2
figure(7)
yyaxis right 
plot(LRtime,O18,'linewidth',1);
ylabel ('dO18')
hold on
yyaxis left
bar(binEdges,binMean,'faceAlpha',0.5)
title ('Average SiO2 per 1 ka vs LR04')
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('SiO2 [wt%]')
%% Kaiser et al 2005 ODP SST and SiO2
figure(8)
yyaxis right 
plot(ksst_age,ksst);
ylabel (' ODP Site 202-1233 SST')
hold on
yyaxis left
bar(binEdges,binMean,'faceAlpha',0.5)
title ('Average SiO2 per 1 ka vs ODP Site 202-1233 SST')
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('SiO2 [wt%]')
%% EPICA Dome C CO2 and SiO2
figure(9)
yyaxis right 
plot(co2_age,co2,'linewidth',1);
ylabel ('EPICA Dome C CO2')
hold on
yyaxis left
bar(binEdges,binMean,'faceAlpha',0.5)
title ('Average SiO2 per 1 ka vs EPICA Dome C CO2')
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('SiO2 [wt%]')