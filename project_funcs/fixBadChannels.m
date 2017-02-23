function [ALLEEG, EEG, CURRENTSET] = fixBadChannels( ALLEEG, EEG, CURRENTSET )
%Finds, removes, and interpolates bad channels in the data
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Save current channel structure
chanStruct = EEG.chanlocs;

%Identify bad channels
[ badChannels ] = detectBadChannels( ALLEEG, EEG, CURRENTSET );

%Remove bad channels
EEG = pop_select( EEG,'nochannel',badChannels);

%Interpolate missing channels
EEG = pop_interp(EEG, chanStruct, 'spherical');

end