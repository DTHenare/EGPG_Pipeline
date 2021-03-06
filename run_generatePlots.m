function run_generatePlots()
%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%Load the file
load(strcat(dataFolder,dataFile));
%Get number of participants
numParticipants = size(Output.allData{1},3);
%Create cell array of list of participants
listOfParts = num2cell(1:numParticipants);
%Convert the numbers into strings for listdlg
listOfParts = cellfun(@num2str,listOfParts,'UniformOutput',false);

%Ask user which participants will be included
[partSelection, OK] = listdlg('promptstring','Select the participants you''d like to include','ListString',listOfParts);
if OK==0
    error('You must select at least one participant for plotting')
end

%Ask the user which events will be plotted
[eventSelection, OK] = listdlg('promptstring','Select the events that you''d like to plot','ListString',Output.conditions);
if OK==0
    error('you must select at least one event')
end

%Ask user for plotting parameters
userInput = inputdlg({'Electrode Number','Component Latency Min Time', 'Component Latency Max Time'},'Define electrode and time window',1);
elec = str2num(userInput{1});
compLatencyMin = str2double(userInput(2));
compLatencyMax = str2double(userInput(3));

generatePlots( dataFolder, dataFile, partSelection, eventSelection, elec, compLatencyMin, compLatencyMax, 0, 'fig_' )

end