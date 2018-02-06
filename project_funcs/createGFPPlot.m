function [  ] = createGFPPlot( data, xAxis )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Prepare data, collapse across condition and participant.
data = cat(4,data{:});
data = mean(data,4);
data = mean(data,3);
GFP = std(data,0,2);
Npeaks = 6;

%Create markers vector
[ pks, locs] = findpeaks( GFP, 'SortStr', 'descend');
[ tppks, tplocs] = findpeaks( GFP, xAxis, 'SortStr', 'descend');

%Plot GFP
figure;
plot( xAxis, GFP)
hold on
plot( xAxis, GFP, 'o', 'MarkerIndices', locs(1:Npeaks))
locs2cell = num2cell(tplocs);
locs2str = cellfun(@num2str,locs2cell(:),'UniformOutput',false);
text( tplocs(1:Npeaks), tppks(1:Npeaks), locs2str(1:Npeaks) );

end