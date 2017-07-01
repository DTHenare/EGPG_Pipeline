function [ hasConditions ] = checkAllConditions( triggerNames, currentFile, dataFolder )
%Checks that a participant has all conditions.
%   Detailed explanation goes here

hasConditions = 1;
for j = 1:length(triggerNames)
    if exist(strcat(dataFolder,'Output\',currentFile,'-',triggerNames{j},'.set'), 'file') == 2
    else
        hasConditions = 0;
    end
end

end

