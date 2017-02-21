function [ ALLEEG,EEG,CURRENTSET ] = ERPPreprocess(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath)
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

%Correct trigger latency
[ALLEEG,EEG,CURRENTSET] = correctAmpDelay(ALLEEG, EEG, CURRENTSET);

%Load channel structure
EEG=pop_chanedit(EEG, 'load',{strcat(EGPGPath,'\project_docs\GSN-HydroCel-129.sfp') 'filetype' 'autodetect'},'setref',{'4:132' 'Cz'},'changefield',{132 'datachan' 0});

%High pass filter the data
[ALLEEG, EEG, CURRENTSET] = EGPGFiltering(ALLEEG, EEG, CURRENTSET, EGPGPath, 1);

end