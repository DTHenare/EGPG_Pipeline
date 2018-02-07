function [  ] = createGFPPlot( data, xAxis, chanLocs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Prepare data, collapse across condition and participant.
data = cat(4,data{:});
data = mean(data,4);
data = mean(data,3);
GFP = std(data,0,2);
Npeaks = 5;

%Find all peaks and sort by prominence
[ ~, ~, ~, prom] = findpeaks( GFP );
sortProm = sort(prom,'descend');
%Get min peak prominence for data
MPP = sortProm(Npeaks);
%Get data
[ ~, locs, wdth ] = findpeaks( GFP, 'MinPeakProminence',MPP );
[ tppks, tplocs, tpwidth ] = findpeaks( GFP, xAxis, 'MinPeakProminence',MPP);
%Plot
figure;subplot(2,5,2:4)
findpeaks( GFP, xAxis, 'Annotate', 'extents', 'MinPeakProminence', MPP)
title('Global field power')
%Convert locs to text
roundLocs = round(tplocs);
locs2cell = num2cell(roundLocs);
locs2str = cellfun(@num2str,locs2cell(:),'UniformOutput',false);
%Covert widths to text
roundWidth = round(tpwidth);
width2cell = num2cell(roundWidth);
width2str = cellfun(@num2str,width2cell(:),'UniformOutput',false);
%combine locs and width together for plotting
combinedText = strcat('Peak: ', locs2str, 'ms Width: ', width2str, 'ms');
%plot text on graph
%text( tplocs, tppks, combinedText );

%Plot topographies
for curPlot = 1:5
    topoStart = locs(curPlot)-(wdth(curPlot)/2);
    topoEnd = locs(curPlot)+(wdth(curPlot)/2);
    curData = mean(data(topoStart:topoEnd,:));
    
    subplot(2,5,curPlot+5)
    topoplot(curData, chanLocs, 'electrodes','ptsnumbers');
    title(combinedText(curPlot));
    
end

end