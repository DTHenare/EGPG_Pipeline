function [ badChannels ] = detectBadChannels( EEG )
%Detects bad channels in the data using a range of tests and outputs the
%names of the bad channels.
%Inputs:    EEG = EEG structure produced by eeglab
%Outputs:   badChannels = cell array containing the names of all electrodes
%           identified as bad

%Save original channel structure
tempLocs = EEG.chanlocs;

%Reject channels with abnormal spectrum
[EEG, specFails] = pop_rejchanspec( EEG, 'freqlims', [0 35], 'stdthresh', [-15 3], 'plotchans', 'off');

%Create single list of all failed channels
%allFails = union(specFails,otherThingsWhichIWillHaveOneDay)
allFails = specFails;

%If there are any bad channels, get their labels
if ~isempty(allFails)
    index = 1;
    for i = allFails
        badChannels{index} = tempLocs(i).labels;
        index = index+1;
    end
else
    badChannels = {};
end
end