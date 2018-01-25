%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%Create save file
[~, fileName, fileExt] = fileparts(dataFile);
saveFile = strcat(dataFolder, fileName, '.txt');
fid = fopen(saveFile,'wt');

%Open data and extract necessary values
Output = load(strcat(dataFolder,dataFile));
data = Output.Output.allData;
conditions = Output.Output.conditions;
blMin = -200;
sampFreq = 250;
N = size(data{1,1},3);

%Get info from user
userInput = inputdlg({'Electrode Number','Component Latency (ms)', 'Component width (ms)', 'Use individual peaks? 1 = yes, 0 = no'},'Define electrode and time window',1);
elec = str2num(userInput{1});
compLatencyms = str2double(userInput(2));
compWidth = str2double(userInput(3));
indvPeaks = str2double(userInput(4));

%Check user input is usable

%Convert user values into data values
compWinMin = convertMsToSamp((compLatencyms-compWidth/2), blMin, sampFreq);
compWinMax = convertMsToSamp((compLatencyms+compWidth/2), blMin, sampFreq);

%Create values table
if indvPeaks == 0
    statsValues = getStatsFromGroupWindow(data, conditions, compWinMin, compWinMax, elec);
elseif indvPeaks == 1
    statsValues = getStatsFromIndvWindow(data, conditions, compWinMin, compWinMax, elec);
end

%Write stats values to txt
%Add header with condition names
writeMatrixToTxt( conditions, statsValues, fid);

%Create output plots
xAxis = -200:4:792;
createERPPlot( conditions, data, xAxis, elec, compLatencyms, compWidth );

%Create topoplots
chanlocs =  load('C:\Users\dion\Desktop\EGPG_Pipeline\project_docs\chanlocs.mat');
chanlocs = chanlocs.chanlocs;
createTopoPlot( conditions, data, xAxis, elec, compLatencyms, compWidth, chanlocs );