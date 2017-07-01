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

%Create list of channels
channelList = {STUDY.changrp(:).name};

%Make study design which combines all conditions
STUDY = std_makedesign(STUDY, ALLEEG, 2, 'variable1','condition','variable2','','name','GrandAverage','pairing1','on','pairing2','on','delfiles','off','defaultdesign','off','values1',{triggerNames'},'subjselect',acceptedFiles);

%precompute the new study design
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [(blMin*1000) 0] });
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

%Plot all electrodes on the scalp
[ STUDY, allData, erpTimes ] = std_erpplot(STUDY,ALLEEG,'channels',channelList);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
%Save the figure into the output folder
saveas(gcf,strcat(dataFolder,'Output\GrandAveragePlot.fig'));

%Calculate the global field power
participantCollapsed = mean(allData{1,1},3);
gfp=std(participantCollapsed,0,2);
%Plot the global field power
figure;plot(gfp)
%Save the figure to the output folder
saveas(gcf,strcat(dataFolder,'Output\GlobalFieldPower.fig'));

end

