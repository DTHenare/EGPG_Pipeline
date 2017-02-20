function [  ] = checkSetup_triggers(dataFolder)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Does trigger file exist in the data folder?
if exist(strcat(dataFolder,'\triggerNames.txt'), 'file') ~= 2
    error('There is no triggerNames.txt file in your data folder. Make sure you copy and edit the triggerNames.txt file from the pipeline folder - see ''How to use'' in README.md')
end

%Open text file and store contents in triggerNames
FID = fopen(strcat(dataFolder,'\triggerNames.txt'))
C = textscan(FID, '%s');
triggerNames = C{1,1};



end

