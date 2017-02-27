function [  ] = createOutputObjects( currentFile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[filePath] = fileparts(currentFile);
outputLocation = strcat(filePath,'\Output\');
outputConditionsLocation = strcat(filePath,'\OutputConditions\');
outputInvInfo = strcat(filePath,'\Output\IndividualInfo.mat');

if ~exist(outputLocation, 'dir')
  mkdir(outputLocation);
end

if ~exist(outputConditionsLocation, 'dir')
  mkdir(outputConditionsLocation);
end

if ~exist(outputInvInfo, 'file')
  mkdir(outputInvInfo);
end

end