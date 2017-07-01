function [ hasConditions ] = checkAllConditions( triggerNames, currentFile, dataFolder )
%Checks that a participant has all conditions necessary for being included
%in a study.
%Inputs:    triggerNames = Cell array list of conditions that are needed
%           currentFile = Name of the participant file that is being
%           checked
%           dataFolder = File path to the original data
%Outputs:   hasConditions = 1 or 0 indicating whether the currentFile has a
%           file for each triggerName

%Start by assuming they have the necessary files
hasConditions = 1;
%For each condition, check that the participant has a file saved
for j = 1:length(triggerNames)
    if exist(strcat(dataFolder,'Output\',currentFile,'-',triggerNames{j},'.set'), 'file') == 2
    else
        %If any one of the files is missing, change hasConditions to 0
        hasConditions = 0;
    end
end

end

