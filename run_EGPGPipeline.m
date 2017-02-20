[selectedFile,dataFolder] = uigetfile({'*.*',  'All Files (*.*)'});
if (dataFolder == 0) & (selectedFile == 0) 
        error('Input file is not selected!') 
end

%Get path of pipeline folder
EGPGPath = fileparts(mfilename('fullpath'));

%Create list of files that will be processed
[ fileNames,fileExt ] = getMatchingFiles(strcat(dataFolder, selectedFile));

%Check setup is appropriate
checkSetup(dataFolder);

%Preprocess each file in the data folder
for i = 1:size(fileNames,1)
    currentFile = strcat(dataFolder,fileNames{i,1},fileExt);
    eeglab;
    [ ALLEEG,EEG,CURRENTSET ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath);
    %clear eeglab data
end