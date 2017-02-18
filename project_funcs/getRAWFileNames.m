function [ fileNames ] = getRAWFileNames( inputFolder )
%This function creates a cell array which contains the names of all .RAW
%files in a given folder.
%Inputs:
%   inputFolder - Path of the folder to check
%Outputs:
%   fileNames - A cell array where each row contains the name of one file
%   from the folder (with the .RAW extension removed)

%Get properties of all .RAW files in the given folder
allRAWs = dir(strcat(inputFolder,'\*.RAW'));
%Make fileNum equal the number of .RAW files found in the folder
fileNum = size(allRAWs,1);

%Store only the file names (excluding the .RAW extension) in fileNames
for i = 1:fileNum
    fileNames{i,1} = allRAWs(i,1).name(1:end-4);
end

end