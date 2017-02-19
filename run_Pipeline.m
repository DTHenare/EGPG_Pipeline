[selectedFile,dataFolder] = uigetfile({'*.*',  'All Files (*.*)'});

%Create list of files that will be processed
[ fileNames,fileExt ] = getMatchingFiles(strcat(dataFolder, selectedFile));

%Check trigger file

%Get path of pipeline folder
pipelinePath = fileparts(mfilename('fullpath'));

%Preprocess each file in the data folder
for i = 1:size(fileNames,1)
    currentFile = strcat(dataFolder,fileNames{i,1},fileExt);
    %pipeline(currentFile, pipelinePath);
    disp(strcat('Ouput for loop ',int2str(i),'...'))
    disp(currentFile)
end