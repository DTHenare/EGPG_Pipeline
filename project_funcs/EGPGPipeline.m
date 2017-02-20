function [ ALLEEG,EEG,CURRENTSET ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath)
%This function runs the entire EGPG preprocessing pipeline.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed
%           EGPGPath = path of the EGPG pipeline folder
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Load parameter file
load(strcat(EGPGPath,'\project_docs\Parameters.mat'));

if PARAMETERS.runICA == 1
%ICA preprocess, output weights
end

%ERP preprocess
[ ALLEEG,EEG,CURRENTSET ] = ERPPreprocess(ALLEEG, EEG, CURRENTSET, currentFile);

if PARAMETERS.runICA == 1
%ERP ICA clean - load ERP, add weights, clean
end

%Artificact rejection

%Extract conditions

end

