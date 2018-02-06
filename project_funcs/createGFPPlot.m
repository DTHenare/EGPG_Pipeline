function [  ] = createGFPPlot( data, xAxis )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Prepare data, collapse across condition and participant.
data = cat(4,data{:});
data = mean(data,4);
data = mean(data,3);
GFP = std(data,0,2);

%Create markers vector
[~,LOCS] = findpeaks(GFP,xAxis,'NPeaks',5);

%Plot GFP
figure;
plot( xAxis, GFP, 'o', 'MarkerIndices', LOCS, 'MarkerFaceColor', 'red', 'MarkerSize', 15)

end