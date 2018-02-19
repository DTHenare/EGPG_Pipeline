function [  ] = getStatsValues( dataFolder, dataFile, saveFile, elec, compWinMin, compWinMax, indvPeaks, eventSelection, partSelection )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%getStatsValues( dataFolder, dataFile, ['Dist_p' int2str(i) '.txt'], elecs{i}, widthMin(i), widthMax(i), 10, eventSelection, partSelection )

%Open data and extract necessary values
load(strcat(dataFolder,dataFile));
data = Output.allData(eventSelection);
data = cellfun(@(x) x(:,:,partSelection), data, 'UniformOutput' , false); %Get user selected participants
conditions = Output.conditions(eventSelection);
blMin = -200;
sampFreq = 250;

%Create save file
fid = fopen(saveFile,'wt');

%Convert user values into data values
compWinMin = convertMsToSamp(compWinMin, blMin, sampFreq);
compWinMax = convertMsToSamp(compWinMax, blMin, sampFreq); 

%Jack knife data
if false
    data = jackKnifeData(data);
end

%Create values table
if indvPeaks == 0
    statsValues = getStatsFromGroupWindow(data, conditions, compWinMin, compWinMax, elec);
else
    statsValues = getStatsFromIndvWindow(data, conditions, compWinMin, compWinMax, elec, indvPeaks);
end

%Write stats values to txt
%Add header with condition names
writeMatrixToTxt( conditions, statsValues, fid );


%% Plotting now in sepearate script
% %Create output plots
% xAxis = -200:4:792;
% createERPPlot( conditions, data, xAxis, elec, compLatencyms, compWidth );
% 
% %Create topoplots
% chanlocs =  Output.Output.chanlocs;
% createTopoPlot( conditions, data, xAxis, elec, compLatencyms, compWidth, compWinMin, compWinMax, chanlocs );

end