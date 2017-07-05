function [  ] = createStudyOutput( STUDY, ALLEEG, triggerNames, acceptedFiles, dataFolder, blMin )
%Uses the study structure to create some figures based on the average of
%all conditions that could help to guide electrode and time window
%selection
%Inputs:    STUDY = Study structure produced by eeglab.
%           ALLEEG = ALLEEG structure produced by eeglab.
%           triggerNames = cell array of condition names in the STUDY.
%           acceptedFiles = list of participants that were included in the
%           studycreation.
%           dataFolder = file path to the original data folder.
%           blMin = time in seconds that the prestimulus period begins
%           relative to the event trigger.

%Make study design which combines all conditions
STUDY = std_makedesign(STUDY, ALLEEG, 2, 'variable1','condition','variable2','','name','GrandAverage','pairing1','on','pairing2','on','delfiles','off','defaultdesign','off','values1',{triggerNames'},'subjselect',acceptedFiles);

%precompute the new study design
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [(blMin*1000) 0] });
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

%Grab some parameters from the EEG data
channelList = {STUDY.changrp(:).name};
chanLocs = EEG(1).chanlocs;
epochEnd = EEG(1).xmax*1000;
sampInt = 1000/EEG(1).srate;
postStimX = 0:sampInt:epochEnd;
postStimLength = length(postStimX);

%Plot all electrodes on the scalp
[ STUDY, allData ] = std_erpplot(STUDY,ALLEEG,'channels',channelList);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
%Save the figure into the output folder
saveas(gcf,strcat(dataFolder,'Output\StudyPlots\GrandAveragePlot.fig'));

%Calculate the global field power
participantCollapsed = mean(allData{1,1},3);
gfp=std(participantCollapsed,0,2);

%Extract peak values, locations, widths, and prominence for poststim GFP
[peaks,locs,w,p]=findpeaks(gfp(end-(postStimLength-1):end));
%Sort by prominence
[sortedP, sortIndP ]= sort(p, 'descend');
%plot 5 most prominent peaks on GFP
figure;subplot(2,5,2:4)
findpeaks(gfp(end-(postStimLength-1):end),postStimX,'MinPeakProminence',sortedP(5),'Annotate','extents')
%Set y axis limits
ymin = 0;
ymax = floor(peaks(sortIndP(1))+1);
ylim([ymin ymax]);

%Extract location of the 5 most prominent peaks and their widths
top5Locs = locs(sortIndP(1:5))*sampInt;
top5Widths = w(sortIndP(1:5));
%flip to ascending order
top5Locs = flipud(top5Locs);
top5Widths = flipud(top5Widths);

for i = 1:5
    %Get time window for topography from the peaks
    topoTimePoint = top5Locs(i)+abs(blMin*1000);
    topoLabel = num2str(topoTimePoint);
    topoHalfWidth = floor(top5Widths(i)/2);
    
    %Set parameters for plotting topography
    STUDY = pop_erpparams(STUDY, 'topotime',[topoTimePoint-topoHalfWidth, topoTimePoint+topoHalfWidth] );
    %Extract topo values
    [STUDY, curTopoData] = std_erpplot(STUDY,ALLEEG,'noplot','on','channels',channelList);
    %Average across participants
    curTopoData= mean(curTopoData{1,1},3);
    %plot topography on subplot
    subplot(2,5,i+5)
    topoplot(curTopoData, chanLocs);
    title(strcat('Peak-',int2str(i)),'(',topoLabel,'ms)');
end

%Save GFP data
save(strcat(dataFolder,'Output\ProcessingInfo\GFP.mat'),'gfp');
%Save the figure to the output folder
saveas(gcf,strcat(dataFolder,'Output\StudyPlots\GFP-guided-topos.fig'));

end

