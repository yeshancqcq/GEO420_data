%% Chile and LR04 Analysis
%% load data 
load('LR04.mat');
load('chile_dates.mat'); %georoc + svz data from EM papers
load('chile_sio2.mat'); %georoc + svz data from EM papers 
S=find(chile_dates<200); % only look at SVZ dates 200 ka to present 
chile_dates=chile_dates(S);
%% Chile data histogram 
figure(1)
histogram(chile_dates,200); % 1000 year bins 
set(gca,'XDir','reverse')
xlabel('age [ka]')
ylabel('count')
title('eruptions per 1 ka')
%% eruptions per 1000 years
[N,edges]=histcounts(chile_dates,200); %count histogram bin entries (200 bins = 1 per 1000 yrs)
figure(2)
LRtime=LR04(1:201,1); % only look at LR04 from 200 ka to present 
O18=LR04(1:201,2);
yyaxis right 
plot(LRtime,O18);
ylabel ('dO18')
hold on
yyaxis left
plot(N)
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('eruptions per 1 ka')
%% Visualize LR04 and SVZ (?)
holder=ones(size(chile_dates))*0.0001; %wtf is going on but it works (?)
holder=holder+4;
figure(3)
plot(LRtime,O18)
hold on
scatter(chile_dates,holder)
set(gca,'XDir','reverse')
xlabel('time [ka]')
ylabel('d18O [o/oo]')
hold off 
%% SiO2 content 
figure(4)
SiO2=chile_sio2(:,2);
S2=find(chile_dates<200); % only look at SVZ dates 200 ka to present 
SiO2=SiO2(S2);
scatter(chile_dates,SiO2);
set(gca,'XDir','reverse')
title ('SiO2 through time')
ylabel ('SiO2')
xlabel('age[ka]')
%%
x=chile_sio2(:,1); %x is time
y=chile_sio2(:,2); %y is sio2 content
topEdge=200; %define limits
botEdge=0;%define limits
numBins=50; %one bin per 4 ka
binEdges=linspace(botEdge,topEdge,numBins+1);
[h,whichBin]=histc(x,binEdges);
binMean=zeros(1,numBins+1);
for i=1:numBins
    flagBinMembers=(whichBin==i); %which members are in bin? binary
    binMembers=y(flagBinMembers); %index into y 
    binMean(i)=nanmean(binMembers);
end
binMean(find(isnan(binMean)))=0;
figure(5)
bar(binEdges,binMean);
set(gca,'XDir','reverse')
title ('Average SiO2 per 4 ka')
ylabel ('SiO2 [wt%]')
xlabel('Time [ka]')
%% Visualize LR04 and SiO2
figure(6)
yyaxis right 
plot(LRtime,O18,'linewidth',1);
ylabel ('dO18')
hold on
yyaxis left
bar(binEdges,binMean,'faceAlpha',0.5)
set(gca,'XDir','reverse')
xlabel('age[ka]')
ylabel('SiO2 [wt%]')
