%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%Get info from user
userInput = inputdlg({'Electrode Number','Component Latency (ms)', 'Component width (ms)', 'Use individual peaks? 1 = yes, 0 = no'},'Define electrode and time window',1);
elec = str2num(userInput{1});
compLatencyms = str2double(userInput(2));
compWidth = str2double(userInput(3));
indvPeaks = str2double(userInput(4));

%Check user data is acceptable

%Run getStatsValues
getStatsValues( dataFolder, dataFile, elec, compLatencyms, compWidth, indvPeaks );