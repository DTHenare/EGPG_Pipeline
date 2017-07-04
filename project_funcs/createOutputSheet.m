function [ Output ] = createOutputSheet( STUDY, ALLEEG, channelList, conditions )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [blMin 0] });
[ ~, Output.allData, Output.erpTimes ] = std_erpplot(STUDY,ALLEEG,'channels',channelList);
close(gcf);

%Average across participants
%Output.allData = cellfun(@(x) mean(x,3),Output.allData,'un',0);

%Add condition labels to output
Output.conditions = conditions;

end

