function [ALLEEG, EEG, CURRENTSET, badChannels, chanStruct] = fixBadChannels( ALLEEG, EEG, CURRENTSET )
%Finds, removes, and interpolates bad channels in the data
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           badChannels = list of channels that were marked as bad
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Save current channel structure
chanStruct = EEG.chanlocs;

%Identify bad channels
[ badChannels ] = detectBadChannels( EEG );
%Remove HEOGs if they were selected
badChannels(strcmp('E125',badChannels))=[];
badChannels(strcmp('E128',badChannels))=[];

%If there are any bad channels, remove and interpolate them
if ~isempty(badChannels)
    %Remove bad channels
    EEG = pop_select( EEG,'nochannel',badChannels);
    
    %Interpolate missing channels
    EEG = pop_interp(EEG, chanStruct, 'spherical');
end
end