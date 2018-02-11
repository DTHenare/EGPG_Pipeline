function [  ] = generatePlots( dataFolder, dataFile, partSelection, eventSelection, elec, compLatencyMin, compLatencyMax )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Load the file
load(strcat(dataFolder,dataFile));

%Configure data based on user input
data = Output.allData(eventSelection); %Get user selected condition data
data = cellfun(@(x) x(:,:,partSelection), data, 'UniformOutput' , false); %Get user selected participants
conditions = Output.conditions(eventSelection); %Get user selected condition labels
blMin = -200;
sampFreq = 250;
compWinMin = convertMsToSamp( compLatencyMin, blMin, sampFreq );
compWinMax = convertMsToSamp( compLatencyMax, blMin, sampFreq );

%% Make plots
xAxis = -200:4:792;

%Create output plots
createERPPlot( conditions, data, xAxis, elec, compWinMin, compWinMax );

%Create topoplots
chanlocs =  Output.chanlocs;
createTopoPlot( conditions, data, xAxis, elec, compWinMin, compWinMax, chanlocs );

end

