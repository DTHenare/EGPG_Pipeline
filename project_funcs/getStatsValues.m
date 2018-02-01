function [  ] = getStatsValues( dataFolder, dataFile, elec, compLatencyms, compWidth, indvPeaks )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Open data and extract necessary values
Output = load(strcat(dataFolder,dataFile));
data = Output.Output.allData;
conditions = Output.Output.conditions;
blMin = -200;
sampFreq = 250;
N = size(data{1,1},3);

%Create save file
[~, fileName, fileExt] = fileparts(dataFile);
saveFile = strcat(dataFolder, fileName, '.txt');
fid = fopen(saveFile,'wt');

%Convert user values into data values
compWinMin = convertMsToSamp((compLatencyms-compWidth/2), blMin, sampFreq);
compWinMax = convertMsToSamp((compLatencyms+compWidth/2), blMin, sampFreq); 

%Create values table
if indvPeaks == 0
    statsValues = getStatsFromGroupWindow(data, conditions, compWinMin, compWinMax, elec);
else
    statsValues = getStatsFromIndvWindow(data, conditions, compWinMin, compWinMax, elec, 1, indvPeaks);
end

%Write stats values to txt
%Add header with condition names
writeMatrixToTxt( conditions, statsValues, fid);

%Create output plots
xAxis = -200:4:792;
createERPPlot( conditions, data, xAxis, elec, compLatencyms, compWidth );

%Create topoplots
chanlocs =  load('C:\Users\dhen061\Desktop\EGPG_Pipeline\project_docs\chanlocs.mat');
chanlocs = chanlocs.chanlocs;
createTopoPlot( conditions, data, xAxis, elec, compLatencyms, compWidth, compWinMin, compWinMax, chanlocs );

end