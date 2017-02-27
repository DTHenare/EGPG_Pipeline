%This script provides a user friendly wrapper for the EGPG pipeline. When
%run, it pops open a file explorer for the user to navigate to a data file.
%It then runs the pipeilne for all matching files within the selected
%folder. It also performs a number of checks on the data in order to check
%that everything has been set up appropriately.

%Pop up the file explorer for the user to select their file
[selectedFile,dataFolder] = uigetfile({'*.*',  'All Files (*.*)'});
if (dataFolder == 0) & (selectedFile == 0)
        error('Input file is not selected!')
end

%Get path of pipeline folder
EGPGPath = fileparts(mfilename('fullpath'));

%Create list of files that will be processed
[ fileNames,fileExt ] = getMatchingFiles(strcat(dataFolder, selectedFile));

%Check setup is appropriate
checkSetup(dataFolder, EGPGPath, selectedFile);

%Preprocess each file in the data folder
for i = 1:size(fileNames,1)
    currentFile = strcat(dataFolder,fileNames{i,1},fileExt);
    eeglab;
    [ ALLEEG,EEG,CURRENTSET ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath, i);
    %clear eeglab data
end