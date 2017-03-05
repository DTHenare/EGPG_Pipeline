function [  ] = writeGroupOutput( currentFile, IndividualInfo, fileNum, triggerNames, fileNames )
%Writes summary statistics of the preprocessing procedure to a .mat file
%Inputs:    currentFile = path of the input file
%           IndividualInfo = struct containing an individual's processing
%           statistics
%           fileNum = number indicating which file form the current
%           experiment is being processed

%get the path to the data folder
[filePath] = fileparts(currentFile);
%load the group info structure if it exists
if exist(strcat(filePath,'\Output\ProcessingInfo\GroupInfo.mat'), 'file')
load(strcat(filePath,'\Output\ProcessingInfo\GroupInfo.mat'));
end

%add current participant values to the group struct
GroupInfo.triggerNames = triggerNames;
GroupInfo.fileNames = fileNames;
GroupInfo.badChannels{fileNum,1} = IndividualInfo.badChannels;
GroupInfo.epochNum(fileNum,1) = IndividualInfo.epochNum;
GroupInfo.horizFails{fileNum,1} = IndividualInfo.horizFails;
GroupInfo.numGenFails(fileNum,1) = IndividualInfo.numGenFails;
GroupInfo.meanHEOG(fileNum,1) = IndividualInfo.meanHEOG;

%Save into the processingInfo folder
save(strcat(filePath,'\Output\ProcessingInfo\GroupInfo.mat'),'GroupInfo')

end

