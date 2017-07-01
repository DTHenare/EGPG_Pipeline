function [ studyCells, failedFiles, acceptedFiles ] = createStudyDataArray(triggerNames, fileNames, dataFolder)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

k=1;
part=1;
for i = 1:length(fileNames)
    %Check that this participant has a file for every condition
    hasConditions = checkAllConditions( triggerNames, fileNames{i}, dataFolder );
    
    %If participant has all necessary files, add them to the study
    if hasConditions == 1
        for j = 1:length(triggerNames)
            currentLoadPath = strcat(dataFolder,'Output\',fileNames{i},'-',triggerNames{j},'.set');
            studyCells{k} = { 'index', k, 'load', currentLoadPath, 'subject', fileNames{i}, 'condition', triggerNames{j}};
            acceptedFiles{1,k} = fileNames{i};
            k=k+1;
        end
    else
        failedFiles{part} = fileNames{i};
        part=part+1;
    end
end

end

