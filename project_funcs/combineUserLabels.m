function [ newData ]  = combineUserLabels( Output, combineLabels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
allData  = Output.allData;
totalConds = length(Output.conditions);
for newCond = 1:size(combineLabels,1)
    %create array for finding matching labels
    condLocs = zeros(totalConds,1);
    %Now find cell locations which match the conditions we're combining
    for curLabels = 1:size(combineLabels,2)
        condLocs = condLocs + strcmp(Output.conditions,combineLabels{newCond,curLabels});
    end
    %convert locations to a logical array
    condLocs = logical(condLocs);
    %Create 4D array from the cells holding the data we'll combine
    matchingConditions = cat(4,allData{condLocs});
    
    %average across the conditions
    newData{newCond,1} = mean(matchingConditions,4);
end


end

