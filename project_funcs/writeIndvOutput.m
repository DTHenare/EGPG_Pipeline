function [  ] = writeIndvOutput( currentFile, fileNum, badChannels, epochNum, horizFails, numGenFails, meanHEOG)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%get the path to the data folder
[filePath] = fileparts(currentFile);
%load the indivbidual info table
load(strcat(filePath,'\Output\IndividualInfo.mat'));

%add current participant values to the IndividualInfo struct
IndividualInfo.badChannels{fileNum,1} = badChannels;
IndividualInfo.epochNum(fileNum,1) = epochNum;
IndividualInfo.horizFails{fileNum,1} = horizFails;
IndividualInfo.numGenFails(fileNum,1) = numGenFails;
IndividualInfo.meanHEOG(fileNum,1) = meanHEOG;

save(strcat(filePath,'\Output\IndividualInfo.mat'),'IndividualInfo')

end