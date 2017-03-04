function [  ] = createOutputObjects( currentFile )
%Checks whether the output locations exist and if the don't, creates the
%folders.
%Inputs:    currentFile = path of the input file

[filePath] = fileparts(currentFile);
outputLocation = strcat(filePath,'\Output\');
outputInfoLocation = strcat(filePath,'\Output\ProcessingInfo\');

%create folder for outputting participant data (if it doesn't exist)
if ~exist(outputLocation, 'dir')
  mkdir(outputLocation);
end

%create folder for epoched data (if it doesn't exist)
if ~exist(outputInfoLocation, 'dir')
  mkdir(outputInfoLocation);
end

end