function [ electrodePairs ] = createElectrodeList( chanlocs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Find total number of electrodes
numElectrodes = size(chanlocs,2);

%Extract midline electrodes
midElecs = getMidlineElecs(chanlocs, numElectrodes);

% Create list of pairs
pairedList = getElectrodePairs(chanlocs, numElectrodes);

%Combine midElecs and pairedElecs into final list
electrodePairs = cat(1,pairedList,midElecs);

end

