%% Chile and LR04 Analysis
%% load data 
clear all 
close all
load('LR04.txt'); %Global Benthic d18O (Lisiecki and Raymo 2005)
load('edc_co2.txt') %EPICA DOME C CO2 (Monnin et al 2006)
load('kaiser_sst.txt') %70 ka SST record for ODP Site 202-1233 (Kaiser et al 2005)
load('wdc_co2.txt') %WDC CO2 (Marcott et al 2014)
load('wdc_ch4.txt') %WDC CH4 (Marcott et al 2014)
load('wdc_d18o.txt') %WDC d18O (Marcott et al 2014)
load('LDI_SST.txt') %Long Chain Diol SST record De Bar et al 2018
load('andes_30ka.txt'); %georoc + svz data from EM papers
load('andes_30ka_sio2.txt'); %georoc + svz data from EM papers 
%% Only look at last 30 ka
% S=find(chile_dates<30); % only look at SVZ dates 30 ka to present 
% chile_dates=chile_dates(S);
%% Assign Variables
% CO2
edcco2=edc_co2(:,3);
edcco2_age=edc_co2(:,2);
wdcco2=wdc_co2(:,4);
wdcco2_age=wdc_co2(:,2);

%CH4
wdcch4=wdc_ch4(:,4);
wdcch4_age=wdc_ch4(:,2)

%D18O
wdcd18o=wdc_d18o(:,4);
wdcd18o_age=wdc_d18o(:,2);
LRtime=LR04(1:31,1); % only look at LR04 from 30 ka to present 
O18=LR04(1:31,2);

%SST
ksst=kaiser_sst(:,2);
ksst_age=kaiser_sst(:,1);
S1=find(ksst_age<31); % only look at dates 30 ka to present 
ksst_age=ksst_age(S1);
ksst=ksst(S1);

ldisst=LDI_SST(:,2);
ldisst_age=LDI_SST(:,1);
S2=find(ldisst_age<31); % only look at dates 30 ka to present 
ldisst_age=ldisst_age(S2)
ldisst=ldisst(S2);

%SiO2
SiO2=andes_30ka_sio2(:,2);
Chile_SiTime=andes_30ka_sio2(:,1);
S3=find(Chile_SiTime<31); % only look at dates 30 ka to present 
SiO2=SiO2(S3);
Chile_SiTime=Chile_SiTime(S3);
%% Andean Volcanic Events histogram 
figure(1)
histogram(andes_30ka,30); % 1000 year bins 
set(gca,'XDir','reverse')
title('Andean Volcanic Events per 1 ka')
xlabel('age [ka]')
ylabel('count')
%% Calculate mean eruption rate per 1 ka over 0-5 ka
% [N,edges]=histcounts(chile_dates,30); %count histogram bin entries (30 bins = 1 per 1000 yrs)

%calculate mean per kyr eruption rate from 0-5 ka (Watt 2013 et al fig 10)
for i=1:4
    ka(i)=numel(find ((andes_30ka>i)&(andes_30ka<i+1)));
end
mean_ka_rate=mean(ka);

%% Normalize (# events per 1 ka normalized to 0-5 ka mean rate)
for i=1:29
    ka(i)=numel(find ((andes_30ka>i)&(andes_30ka<i+1)));
end
mean_ka_norm=ka./mean_ka_rate;

plot(mean_ka_norm)
set(gca,'XDir','reverse')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
title('Andean Eruption Rate')
%% LR04 and number of volcanic events 
holder=ones(size(andes_30ka))*0.0001; %wtf is going on but it works (?)
holder=holder+4;
figure(2)
plot(LRtime,O18)
hold on
scatter(andes_30ka,holder)
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
yyaxis right 
scatter(ksst_age,ksst);
ylabel (' ODP Site 202-1233 SST')
hold on
yyaxis left
plot(mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and ODP Site 202-1233 SST')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
%% De Bar et al 2018 LDI SST and Normalized Eruption Rate (per 1 ka)
figure(5)
yyaxis right 
plot(ldisst_age,ldisst);
ylabel ('ODP Site 202-1234 SST')
hold on
yyaxis left
plot(mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and ODP Site 202-1234 SST')
xlabel('time[ka]')
ylabel('normalized per ka eruption rate')
%% SST SUBPLOT
figure(6)
ax(1)=subplot(2,1,1)
yyaxis(ax(1),'right')
plot(ax(1),ksst_age,ksst);
ylabel (ax(1),'DP Site 202-1233 SST')
hold on
yyaxis(ax(1),'left')
plot(ax(1),mean_ka_norm)
set(gca,'XDir','reverse')
title(ax(1),'Andean Eruption rate and ODP Site 202-1233 SST')
xlabel(ax(1),'time[ka]')
ylabel(ax(1),'normalized per ka eruption rate')

ax(2)=subplot(2,1,2)
yyaxis(ax(2),'right')
plot(ax(2),ldisst_age,ldisst);
ylabel (ax(2),'ODP Site 202-1234 SST')
hold on
yyaxis left
plot(ax(2),mean_ka_norm)
set(gca,'XDir','reverse')
title(ax(2),'Andean Eruption rate and ODP Site 202-1234 SST')
xlabel(ax(2),'time[ka]')
ylabel(ax(2),'normalized per ka eruption rate')
%% EDC and WDC CO2 and Normalized Eruption Rate (per 1ka)
figure(7)
yyaxis('right')
plot(edcco2_age,edcco2);
ylabel ('CO2 [ppm]')
hold on
plot(wdcco2_age,wdcco2);
hold off
yyaxis ('left')
plot(mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and Antarctic CO2')
xlabel('Time[ka]')
ylabel('Normalized per ka eruption rate')
%% Marcott et al 2014 data and Normalized Eruption Rate (per 1 ka) SUBPLOT
figure(8)
ax(1)=subplot(3,1,1)
yyaxis(ax(1),'right')
plot(ax(1),edcco2_age,edcco2);
ylabel (ax(1),'CO2 [ppm]')
hold on
plot(ax(1),wdcco2_age,wdcco2);
hold off
yyaxis (ax(1),'left')
plot(ax(1),mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and EPICA Dome C CO2')
xlabel(ax(1),'time[ka]')
ylabel(ax(1),'Normalized per ka eruption rate')

ax(2)=subplot(3,1,2)
yyaxis(ax(2),'right')
plot(ax(2),wdcch4_age,wdcch4);
ylabel (ax(2),'CH4 [ppb]')
hold on
yyaxis(ax(2),'left')
plot(ax(2),mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and WDC CH4')
xlabel(ax(2),'time[ka]')
ylabel(ax(2),'normalized per ka eruption rate')

ax(3)=subplot(3,1,3)
yyaxis(ax(3),'right')
plot(ax(3),wdcd18o_age,wdcd18o);
ylabel (ax(3),'d18O [per mil]')
hold on
yyaxis(ax(3),'left')
plot(ax(3),mean_ka_norm)
set(gca,'XDir','reverse')
title('Andean Eruption rate and WDC d18O')
xlabel(ax(3),'time[ka]')
ylabel(ax(3),'normalized per ka eruption rate')
%% SiO2 content 
figure(9)
scatter(Chile_SiTime,SiO2);
set(gca,'XDir','reverse')
title ('SiO2 through time')
ylabel ('SiO2')
xlabel('age[ka]')
%%
x=andes_30ka_sio2(:,1); %x is time
y=andes_30ka_sio2(:,2); %y is sio2 content
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
figure(10)
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
figure(11)
yyaxis right 
scatter(ksst_age,ksst);
ylabel (' ODP Site 202-1233 SST')
hold on
yyaxis left
bar(binEdges,binMean,'faceAlpha',0.5)
title ('Average SiO2 per 1 ka vs ODP Site 202-1233 SST')
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('SiO2 [wt%]')
%% EDC and WDC CO2 and SiO2
figure(12)
yyaxis right 
plot(edcco2_age,edcco2);
ylabel ('CO2 [ppm]')
hold on
plot(wdcco2_age,wdcco2);
hold off
yyaxis left
bar(binEdges,binMean,'faceAlpha',0.5)
title ('Average SiO2 per 1 ka vs EPICA Dome C CO2')
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('SiO2 [wt%]')