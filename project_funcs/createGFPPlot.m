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
[ pks, locs, wdth, prom ] = findpeaks( GFP, 'MinPeakProminence',MPP );
[ tppks, tplocs, tpwidth ] = findpeaks( GFP, xAxis, 'MinPeakProminence',MPP );
%Plot
figure;subplot(2,5,1:3)
findpeaks( GFP, xAxis, 'Annotate', 'extents', 'MinPeakProminence', MPP )
title('Global field power')

%Plot spatial GFP
sGFP = std(data);
subplot(2,5,4:5);
topoplot(sGFP,chanLocs,'electrodes','ptsnumbers');
title('Spatial GFP');

%Get width indices
widthHeights = pks-(prom/2);
for peak = 1:Npeaks
    %get valleyMin and ValleyMax
    if peak>1 & peak<Npeaks
        preShared = GFP(locs(peak-1):locs(peak));
        [ ~, valleyMin(peak)] = min(preShared);
        valleyMin(peak) = valleyMin(peak) + locs(peak-1);
        postShared = GFP(locs(peak):locs(peak+1));
        [ ~, valleyMax(peak)] = min(postShared);
        valleyMax(peak) = valleyMax(peak) + locs(peak);
    elseif peak==1
        valleyMin(peak) = 0;
        postShared = GFP(locs(peak):locs(peak+1));
        [ ~, valleyMax(peak)] = min(postShared);
        valleyMax(peak) = valleyMax(peak) + locs(peak);
    elseif peak == Npeaks
        preShared = GFP(locs(peak-1):locs(peak));
        [ ~, valleyMin(peak)] = min(preShared);
        valleyMin(peak) = valleyMin(peak) + locs(peak-1);
        valleyMax(peak) = length(GFP);
    end
    
    matches = GFP(locs(peak):end)<=widthHeights(peak);
    xlim = find( matches, 1, 'first');
    widthMax(peak) = min(locs(peak)+xlim-1,valleyMax(peak));
    widthMin(peak) = max(widthMax(peak)-round(wdth(peak)),valleyMin(peak));
end

%Create plot text
%Convert locs to text
roundLocs = round(tplocs);
locs2cell = num2cell(roundLocs);
locs2str = cellfun(@num2str,locs2cell(:),'UniformOutput',false);
%Covert widthMin to text
widthMin2cell = num2cell(widthMin*4-200);
widthMin2str = cellfun(@num2str,widthMin2cell(:),'UniformOutput',false);
%Covert widthMax to text
widthMax2cell = num2cell(widthMax*4-200);
widthMax2str = cellfun(@num2str,widthMax2cell(:),'UniformOutput',false);
%combine locs and width together for plotting
combinedText = strcat('Peak = ', locs2str, 'ms Width = ', widthMin2str, ':', widthMax2str, 'ms');
%plot text on graph
%text( tplocs, tppks, combinedText );

%Plot topographies
for curPlot = 1:5
    topoStart = widthMin(curPlot);
    topoEnd = widthMax(curPlot);
    curData = mean(data(topoStart:topoEnd,:));
    
    subplot(2,5,curPlot+5)
    topoplot(curData, chanLocs, 'electrodes','ptsnumbers');
    title(combinedText(curPlot));
    
end

end