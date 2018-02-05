function [ newCell ]  = combineConditionLabels( dataFolder, dataFile, newLabel, combineLabels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%Load the file
load(strcat(dataFolder,dataFile));

newData  = Output.allData;
totalConds = length(Output.conditions);
condLocs = zeros(totalConds,1);

%Find cell locations which match the conditions we're combining
for curLabel = 1:length(combineLabels)
    condLocs = condLocs + strcmp(Output.conditions,combineLabels{curLabel});
end
condLocs = logical(condLocs);
%Create 4D array from the cells holding the data we'll combine
matchingConditions = cat(4,newData{condLocs});

%average across the conditions
newCell = mean(matchingConditions,4);

%Create new output data remove the combined cells and add the new data
nonMatchingConditions = ~matchingConditions;
newOutput = newData(nonMatchingConditions);
newOutput{end+1} = newCell;
Output.allData = newOutput;

%Remove the labels of the combined conditions, and add new label
Output.conditions(nonMatchingConditions);
Output.conditions{end+1} = newLabel;

end