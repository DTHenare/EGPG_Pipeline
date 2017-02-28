function [  ] = createOutputObjects( currentFile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[filePath] = fileparts(currentFile);
outputLocation = strcat(filePath,'\Output\');
outputConditionsLocation = strcat(filePath,'\OutputConditions\');
outputInvInfo = strcat(filePath,'\Output\IndividualInfo.mat');

%create folder for outputting participant data (if it doesn't exist)
if ~exist(outputLocation, 'dir')
  mkdir(outputLocation);
end

%create folder for epoched data (if it doesn't exist)
if ~exist(outputConditionsLocation, 'dir')
  mkdir(outputConditionsLocation);
end

%Create file for saving processing statistics (if it doesn't exist)
if ~exist(outputInvInfo, 'file')
   badChannels = {};
   epochNum = [];
   horizFails = {};
   numGenFails = [];
   meanHEOG = [];
   IndividualInfo = struct('badChannels',badChannels, 'epochNum',epochNum, 'horizFails',horizFails, 'numGenFails',numGenFails, 'meanHEOG',meanHEOG);
   save(strcat(outputLocation,'IndividualInfo.mat'),'IndividualInfo')
end

end