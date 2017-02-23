function [ badChannels ] = detectBadChannels( EEG )
%Detects bad channels in the data using a range of tests and outputs the
%names of the bad channels.
%Inputs:    EEG = EEG structure produced by eeglab
%Outputs:   badChannels = cell array containing the names of all electrodes
%           identified as bad

%Reject channels with abnormal spectrum
[EEG, specFails] = pop_rejchanspec( EEG, 'freqlims', [0 35], 'stdthresh', [-15 3], 'plotchans', 'off');

%Create single list of all failed channels
%allFails = union(specFails,otherThingsWhichIWillHaveOneDay)
allFails = specFails;

index = 1;
for i = allFails
    badChannels{index} = EEG.chanlocs(i).labels;
    index = index+1;
end

