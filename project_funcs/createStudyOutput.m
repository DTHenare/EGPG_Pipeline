function [  ] = createStudyOutput( STUDY, ALLEEG, triggerNames, acceptedFiles, dataFolder, blMin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

channelList = {STUDY.changrp(:).name};

STUDY = std_makedesign(STUDY, ALLEEG, 2, 'variable1','condition','variable2','','name','GrandAverage','pairing1','on','pairing2','on','delfiles','off','defaultdesign','off','values1',{triggerNames'},'subjselect',acceptedFiles);
[STUDY, EEG] = pop_savestudy( STUDY, ALLEEG, 'savemode','resave');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [(blMin*1000) 0] });
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

[ STUDY, allData, erpTimes ] = std_erpplot(STUDY,ALLEEG,'channels',channelList);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

plottable = mean(allData{1,1},3);
gfp=std(plottable,0,2);

save(strcat(dataFolder,'Output\STUDY-Output.mat'),'allData', 'erpTimes');
saveas(gcf,strcat(dataFolder,'Output\GrandAveragePlot.fig'));
figure;plot(gfp)
saveas(gcf,strcat(dataFolder,'Output\GlobalFieldPower.fig'));

end

