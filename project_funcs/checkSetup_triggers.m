function [  ] = checkSetup_triggers(dataFolder, EGPGPath)
%Checks to ensure that the trigger file has been created correctly, and
%produces an error if any test fails.
%   Checks that the file exists in the data folder
%   Checks that the trigger values are not just the defaults
%Inputs:    dataFolder = folder which scontains the users triggerName.txt file
%           EGPGPath = folder which contains the default triggerNames.txt file

%Does trigger file exist in the data folder?
if exist(strcat(dataFolder,'\triggerNames.txt'), 'file') ~= 2
    error('There is no triggerNames.txt file in your data folder. Make sure you copy and edit the triggerNames.txt file from the pipeline folder - see ''How to use'' in README.md')
end

%Open text file and store contents in triggerNames
FID = fopen(strcat(dataFolder,'\triggerNames.txt'));
C = textscan(FID, '%s');
triggerNames = C{1,1};

%If triggers haven't been edited from default, return error message
if ~checkSetup_triggersEdited( triggerNames, EGPGPath )
    error('It looks like you haven''t opened the triggerNames.txt file in your data folder and edited it to reflect the names of your triggers - see ''How to use'' in README.md')
end

end

