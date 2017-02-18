[firstParticipant,dataFolder] = uigetfile;

[ fileNames ] = getRAWFileNames(dataFolder);

%Preprocess each .RAW in the data folder
for i = 1:size(fileNames,1)
    pipeline(dataFolder,fileNames{i,1});
end