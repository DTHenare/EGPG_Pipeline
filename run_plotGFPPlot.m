function [ dataFolder, dataFile, eventSelection, partSelection, widthMin, widthMax ] = run_plotGFPPlot( )
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

%Configure data based on user input
data = Output.allData(eventSelection); %Get user selected condition data
data = cellfun(@(x) x(:,:,partSelection), data, 'UniformOutput' , false); %Get user selected participants
conditions = Output.conditions(eventSelection); %Get user selected condition labels
xAxis = -200:4:792;

[ widthMin, widthMax ] = createGFPPlot( data, xAxis, Output.chanlocs);

end

