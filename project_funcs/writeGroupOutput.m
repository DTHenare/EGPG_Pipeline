function [  ] = writeGroupOutput( currentFile, IndividualInfo, fileNum )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%get the path to the data folder
[filePath] = fileparts(currentFile);
%load the indivbidual info structure if it exists
if exist(strcat(filePath,'\Output\ProcessingInfo\GroupInfo.mat'), 'file')
load(strcat(filePath,'\Output\ProcessingInfo\GroupInfo.mat'));
end

%add current participant values to the IndividualInfo struct
GroupInfo.badChannels{fileNum,1} = IndividualInfo.badChannels;
GroupInfo.epochNum(fileNum,1) = IndividualInfo.epochNum;
GroupInfo.horizFails{fileNum,1} = IndividualInfo.horizFails;
GroupInfo.numGenFails(fileNum,1) = IndividualInfo.numGenFails;
GroupInfo.meanHEOG(fileNum,1) = IndividualInfo.meanHEOG;

save(strcat(filePath,'\Output\ProcessingInfo\GroupInfo.mat'),'GroupInfo')

end

