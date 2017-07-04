function [ Output ] = doubleSubtraction(input, userDesign, electrodePairs)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(userDesign,1)
    %Get labels for current subtraction from userData
    curLabel = userDesign{i,1};
    leftLabel = userDesign{i,2};
    rightLabel = userDesign{i,3};
    
    %Find indices of relevant data in input
    leftIndex = strfind(input.conditions, leftLabel);
    leftIndex = find(not(cellfun('isempty', leftIndex)));
    rightIndex = strfind(input.conditions, rightLabel);
    rightIndex = find(not(cellfun('isempty', rightIndex)));
    
    leftData = input.allData{leftIndex};
    rightData = input.allData{rightIndex};
    
    %first subtraction
    firstSubtraction = leftData-rightData;
    
    
    leftHem = firstSubtraction(:,electrodePairs(:,1));
    rightHem = firstSubtraction(:,electrodePairs(:,2));
    
    %Second subtraction
    secondSubtraction = (rightHem -leftHem)/2;
    
    %Mirror back onto full scalp
    mirroredData(:,electrodePairs(:,1)) = secondSubtraction;
    mirroredData(:,electrodePairs(:,2)) = secondSubtraction;
    
    %Store data
    Output.allData{i} = mirroredData';
    Output.conditions{i} = curLabel';
end
end

