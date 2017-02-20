function [ fileNames,fileExt ] = getMatchingFiles( inputFile )
%This function takes a single file as input, and returns a cell array which
%contains the name of any file which shares the location and extension of
%the input file.
%Inputs:    inputFile = Path of the file which will be matched
%Outputs:   fileNames = A cell array where each row contains the name of 
%           one file from the folder (with the extension removed)
%           fileExt = The extension of the input file

%Identify file type from file name
[filePath,fileName,fileExt] = fileparts(inputFile);

%Get properties of all matching files in the folder
allMatches = dir(strcat(filePath,'\*',fileExt));
%Make fileNum equal the number of matching files found in the folder
fileNum = size(allMatches,1);

%Store only the file names (excluding the extension) in fileNames
extLength = size(fileExt,2);
for i = 1:fileNum
    fileNames{i,1} = allMatches(i,1).name(1:end-extLength);
end

end