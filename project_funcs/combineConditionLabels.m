function [ dataStruct ]  = combineConditionLabels( dataStruct, newLabel, combineLabels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

erpData  = dataStruct.allData;
totalConds = length(dataStruct.conditions);
condLocs = zeros(totalConds,1);

%Find cell locations which match the conditions we're combining
for curLabel = 1:length(combineLabels)
    condLocs = condLocs + strcmp(dataStruct.conditions,combineLabels{curLabel});
end
condLocs = logical(condLocs);
%Create 4D array from the cells holding the data we'll combine
matchingConditions = cat(4,erpData{condLocs});

%average across the conditions
newCell = mean(matchingConditions,4);

%Create new output data remove the combined cells and add the new data
nonMatchingConditions = ~condLocs;
newOutput = erpData(nonMatchingConditions);
newOutput{end+1} = newCell;
dataStruct.allData = newOutput;

%Remove the labels of the combined conditions, and add new label
dataStruct.conditions = dataStruct.conditions(nonMatchingConditions);
dataStruct.conditions{end+1} = newLabel{1};

end