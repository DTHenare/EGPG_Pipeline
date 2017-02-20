function [ ALLEEG,EEG,CURRENTSET ] = ERPPreprocess(ALLEEG, EEG, CURRENTSET, currentFile)
%Processes an EEG data set in a way which is optimal for the production of
%ERPs
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Import data
[ALLEEG,EEG,CURRENTSET] = importEEGData(ALLEEG, EEG, CURRENTSET, currentFile);

end

