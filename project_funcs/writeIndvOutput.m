function [  ] = writeIndvOutput( currentFile, fileNum, badChannels, epochNum, horizFails, numGenFails, meanHEOG)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%get the path to the data folder
[filePath] = fileparts(currentFile);
%load the indivbidual info table
load(filePath,'\Output\IndividualInfo.mat');

%create a table for the current participant processing stats
newTable = table(  badChannels, fileNum, epochNum, horizFails, numGenFails, meanHEOG );
%Add the current participant to the relevant row of the main table
IndividualInfo(fileNum,:) = newTable;

end