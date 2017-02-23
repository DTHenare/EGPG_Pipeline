function [  ] = saveOutput(ALLEEG, EEG, CURRENTSET, saveLocation, saveName)
%
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab

%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

EEG = pop_saveset( EEG, 'filename',strcat(saveName,'.set'),'filepath',saveLocation);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

end

