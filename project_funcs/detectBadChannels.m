function [ALLEEG, EEG, CURRENTSET, badChannels] = detectBadChannels( ALLEEG, EEG, CURRENTSET )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Reject channels with abnormal spectrum
[EEG,specFails] = pop_rejchanspec( EEG, 'freqlims', [0 35], 'stdthresh', [-15 3], 'plotchans', 'off');


%Create single list of all failed channels
badChannels = specFails;

end

