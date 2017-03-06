function [ALLEEG,EEG,CURRENTSET] = importEEGData(ALLEEG, EEG, CURRENTSET, currentFile, segPresent)
%Imports a file into eeglab. Selects the appropriate load function based on
%the file extension.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Extract file parts
[filePath, fileName, fileExt] = fileparts(currentFile);

%Use relevant eeglab function to import data
if strcmp('.RAW',fileExt)
    if segPresent == 0
        EEG = pop_readegi(currentFile, [],[],'auto');
        [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
        EEG = eeg_checkset(EEG);
    elseif segPresent == 1
        EEG = pop_readsegegi(currentFile);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');
    end
elseif strcmp('.set',fileExt)
    EEG = pop_loadset('filename',strcat(fileName,fileExt),'filepath',filePath);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset(EEG);
end
end