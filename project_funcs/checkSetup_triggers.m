function [  ] = checkSetup_triggers(dataFolder, EGPGPath)
%Checks to ensure that the trigger file has been created correctly, and
%produces an error if any test fails.
%Inputs:    dataFolder = folder which contains the users triggerName.txt file
%           EGPGPath = folder which contains the default triggerNames.txt file

%Does trigger file exist in the data folder?
if exist(strcat(dataFolder,'\triggerNames.txt'), 'file') ~= 2
    error('There is no triggerNames.txt file in your data folder. Make sure you copy and edit the triggerNames.txt file from the pipeline folder - see ''How to use'' in README.md')
end

%If triggers haven't been edited from default, return error message
if ~checkSetup_triggersEdited( dataFolder, EGPGPath )
    error('It looks like you haven''t edited the triggerNames.txt file in your data folder to reflect the names of your triggers - see ''How to use'' in README.md')
end

end