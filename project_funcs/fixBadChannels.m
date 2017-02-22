function [ALLEEG, EEG, CURRENTSET] = fixBadChannels( ALLEEG, EEG, CURRENTSET )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Save current channel structure
chanStruct = EEG.chanlocs;

%Identify bad channels
[ ALLEEG, EEG, CURRENTSET, badChannels ] = detectBadChannels( ALLEEG, EEG, CURRENTSET );

%Remove bad channels
EEG = pop_select( EEG,'nochannel',badChannels);

%Interpolate missing channels
EEG = pop_interp(EEG, chanStruct);

end

