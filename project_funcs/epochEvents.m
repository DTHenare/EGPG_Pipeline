function [ALLEEG,EEG,CURRENTSET, epochNum] = epochEvents(ALLEEG, EEG, CURRENTSET, epochMin, epochMax, currentFile, triggerNames)
%Epochs around the relevant events in the EEG data.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           epochMin = time point relative to the event that the epoch
%           should begin
%           epochMax = time point relative to the event that the epoch
%           should end
%           currentFile = path of the EEG file which will be processed
%           triggeNames = cell array containing list of event names that
%           will be epoched
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab
%           epochNum = number of epochs which were generated

%Extract file parts
[filePath, fileName, fileExt] = fileparts(currentFile);

%epoch around all triggerNames
EEG = pop_epoch( EEG, triggerNames, [epochMin epochMax], 'newname', fileName, 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'overwrite', 'on', 'gui', 'off');
EEG = eeg_checkset( EEG );

%create variable to return the number of epochs generated
epochNum = size(EEG.data,3);

end

