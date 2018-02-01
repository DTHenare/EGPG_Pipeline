function [ Output ] = createOutputSheet( STUDY, ALLEEG, channelList, conditions, chanlocs, blMin )
%Outputs the study data into a struct which holds all of the data necessary
%for doing statistical analyses.
%Inputs:    STUDY = STUDY structure taken from eeglab
%           ALLEEG = ALLEEG structure taken from eeglab
%           channelList = list of all channels in the study
%           conditions = cell array with a list of the event labels
%Outputs:   Output = struct holding all of the data

%[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [blMin 0] });
[ ~, Output.allData, Output.erpTimes ] = std_erpplot(STUDY,ALLEEG,'channels',channelList, 'noplot', 'on');

%Add condition labels to output
Output.conditions = conditions;

%Add chanlocs to output
Output.chanlocs = chanlocs;

%Add baseline min to output
Output.blMin = blMin;

%Add channel list to output
Output.channelList = channelList;

end

