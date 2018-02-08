function run_getStatsValues()
%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%load the output file
Output = load(strcat(dataFolder,dataFile));

%Present list of triggers to the user for selection
[UserSelection, OK] = listdlg('promptstring','Select the events that you''d like to include','ListString',Output.Output.conditions);
if OK==0
    error('you must select at least one event')
end

%Get info from user
userInput = inputdlg({'Electrode Number','Component Latency Min (ms)', 'Component Latenycy Max (ms)', 'Use individual peaks? Enter the individual window size or ''0'' to use a group window'},'Define electrode and time window',1);
elec = str2num(userInput{1});
compWinMin = str2double(userInput(2));
compWinMax = str2double(userInput(3));
indvPeaks = str2double(userInput(4));

%Check user data is acceptable

%Run getStatsValues
getStatsValues( dataFolder, dataFile, elec, compWinMin, compWinMax, indvPeaks, UserSelection );
end