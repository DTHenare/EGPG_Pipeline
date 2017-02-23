function [ ALLEEG, EEG ] = saveOutput(ALLEEG, EEG, CURRENTSET, saveLocation, saveName)
%
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           saveLocation = file path where the data will be save
%           saveName = filename that the data will be saved under

EEG = pop_saveset( EEG, 'filename',strcat(saveName,'.set'),'filepath',saveLocation);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

end

