function [  ] = removeBadParticipants( filePath, fileName, acceptedFiles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

load([filePath fileName])

%Remove bad participants
allData = cellfun(@(x) x(:,:,acceptedFiles), Output.allData, 'UniformOutput' , false);

%Copy to output structure
Output.allData = newData;

%Save file
save([filePath fileName],'Output')

end