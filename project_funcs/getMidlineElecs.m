function [  midElecs ] = getMidlineElecs(chanlocs,numElectrodes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Find midline electrodes and store indices in midElecs
midElecs = [];
for i = 1:numElectrodes
    pair=[];
    if chanlocs(1,i).Y < 0.00001 && chanlocs(1,i).Y > -0.00001
        pair = [i,i];
        midElecs = cat(1,midElecs,pair);
    end
end

%Find number of electrodes that are in a pair
numPairedElecs = numElectrodes - size(midElecs,2);

%Find number of pairs
numPairs = numPairedElecs/2;

end

