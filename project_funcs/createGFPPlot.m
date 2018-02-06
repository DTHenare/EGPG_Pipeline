function [  ] = createGFPPlot( data, xAxis )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Prepare data, collapse across condition and participant.
data = cat(4,data{:});
data = mean(data,4);
data = mean(data,3);
GFP = std(data,0,2);
Npeaks = 5;

%Find all peaks and sort by prominence
[ pks, locs, wdth, prom] = findpeaks( GFP );
sortProm = sort(prom,'descend');
%Get min peak prominence for data
MPP = sortProm(Npeaks);
[ tppks, tplocs, tpwidth] = findpeaks( GFP, xAxis, 'MinPeakProminence',MPP);
%Plot
figure;
findpeaks(GFP,xAxis,'Annotate','extents','MinPeakProminence',MPP)
roundLocs = round(tplocs);
locs2cell = num2cell(roundLocs);
locs2str = cellfun(@num2str,locs2cell(:),'UniformOutput',false);
roundWidth = round(tpwidth);
width2cell = num2cell(roundWidth);
width2str = cellfun(@num2str,width2cell(:),'UniformOutput',false);
combinedText = strcat( locs2str, '-', width2str);
text( tplocs, tppks, combinedText );

%Plot topographies


end