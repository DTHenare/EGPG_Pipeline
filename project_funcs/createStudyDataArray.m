function [ studyCells, failedFiles, acceptedFiles ] = createStudyDataArray(triggerNames, fileNames, dataFolder)
%Creates the cell array used to produce a STUDY in eeglab.
%Inputs:    triggerNames = Cell array of all condition labels
%           fileNames = Cell array of all participant files
%           dataFolder = The file path ot the original data
%Outputs:   studyCells = Cell array structure used to produce a STUDY in
%           eeglab
%           failedFiles = List of participants who had a missing condition
%           after preprocessing and therefore weren't included in the
%           studyCells
%           acceptedFiles = All of the participants who were included in
%           the studyCells structure

k=1;
part=1;
acceptedFiles = {};
failedFiles = {};
for i = 1:length(fileNames)
    %Check that this participant has a file for every condition
    hasConditions = checkAllConditions( triggerNames, fileNames{i}, dataFolder );
    
    %If participant has all necessary files, add them to the study
    if hasConditions == 1
        for j = 1:length(triggerNames)
            currentLoadPath = strcat(dataFolder,'Output\',fileNames{i},'-',triggerNames{j},'.set');
            studyCells{k} = { 'index', k, 'load', currentLoadPath, 'subject', fileNames{i}, 'condition', triggerNames{j}};
            %Add their file name to the acceptedFiles array
            acceptedFiles{1,k} = fileNames{i};
            k=k+1;
        end
    else
        %If participant does not have all necessary files, add their name
        %to the failedFiles array
        failedFiles{part} = fileNames{i};
        part=part+1;
    end
end

end

