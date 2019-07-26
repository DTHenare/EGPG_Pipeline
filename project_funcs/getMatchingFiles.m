function [ fileNames,fileExt,segPresent ] = getMatchingFiles( inputFile )
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
%Sort allMatches into date order
[~,sortOrder] = sort([allMatches(:).datenum]);
allMatches = allMatches(sortOrder);

%Make fileNum equal the number of matching files found in the folder
fileNum = size(allMatches,1);
%store length of extension
extLength = size(fileExt,2);
%assume non-segmented files
segPresent = 0;

%Always store the first file in finalNames
fileNames{1,1} = allMatches(1,1).name(1:end-extLength);
j=2;
curTest=1;
%for all other files, only store them if they don't look like segments of
%the previous file
for i = 2:fileNum
    %if the file name is long enough to possibly be a segmented file...
    if length(allMatches(curTest,1).name)>6 && length(allMatches(i,1).name)>6
        %does the start of the file names match?
        startMatch = strcmp(allMatches(i,1).name(1:end-7),allMatches(curTest,1).name(1:end-7));
        %Does the date recorded match?
        dateMatch = strcmp(allMatches(i,1).date(1:end-8),allMatches(curTest,1).date(1:end-8));
        %does the curTest end in 3 integers?
        preMatchEGITemplate = ~isempty(str2num(allMatches(curTest,1).name(end-6:end-4)));
        %does the file i end in 3 integers?
        iMatchEGITemplate = ~isempty(str2num(allMatches(i,1).name(end-6:end-4)));
    else
        %Set all to false if file name is too short to consider segments
        startMatch = 0;
        dateMatch = 0;
        preMatchEGITemplate = 0;
        iMatchEGITemplate = 0;
    end
    if startMatch && dateMatch && preMatchEGITemplate && iMatchEGITemplate
        segPresent = 1;
    else
        fileNames{j,1} = allMatches(i,1).name(1:end-extLength);
        curTest = i;
        j=j+1;
    end
end

%check that something weird hasn't happened. If files are segmented, then
%all of the fileNames should end in 1 otherwise they won't load
if segPresent == 1
    for i = 1:length(fileNames)
        if str2num(fileNames{i}(end)) ~= 1
            error('The files in your data folder look like they''re segmented netsstation files, but I''m having trouble identifying all of the initial files for each participant. Make sure each participant has a file ending in 001. If that''s already true then let me know and send the error file to me! dionhenare@gmail.com')
        end
    end
end

end