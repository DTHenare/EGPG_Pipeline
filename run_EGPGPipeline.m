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
[ fileNames,fileExt, segPresent ] = getMatchingFiles(strcat(dataFolder, selectedFile));

%Open eeglab
eeglab;

%Pop-up list of triggers for user selection
[ triggerNames ] = getTriggerNames(dataFolder, selectedFile);

%Check setup is appropriate
checkSetup(dataFolder, EGPGPath, selectedFile);

%Preprocess each file in the data folder
for i = 1:size(fileNames,1)
    %create path of current file
    currentFile = strcat(dataFolder,fileNames{i,1},fileExt);
    %Run pipeline
    [ ALLEEG,EEG,CURRENTSET,IndividualInfo ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath, triggerNames, segPresent);
    %Add current file's output to the group data
    writeGroupOutput( currentFile, IndividualInfo, i, triggerNames, fileNames )
    %clear eeglab
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end

[ STUDY, ALLEEG, EEG, CURRENTSET ] = createStudySet(STUDY, ALLEEG, EEG, CURRENTSET, triggerNames, fileNames);