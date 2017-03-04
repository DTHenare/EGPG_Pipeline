function [ ALLEEG, EEG, CURRENTSET, IndividualInfo ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath, triggerNames)
%This function runs the entire EGPG preprocessing pipeline.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed
%           EGPGPath = path of the EGPG pipeline folder
%           triggeNames = cell array containing list of event names that
%           will be epoched
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Load parameter file
load(strcat(EGPGPath,'\project_docs\Parameters.mat'));

%Create output folders and files
createOutputObjects( currentFile );

if PARAMETERS.runICA == 1
%ICA preprocess, output weights
end

%ERP preprocess
[ ALLEEG, EEG, CURRENTSET, badChannels, epochNum, horizFails ] = ERPPreprocess(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath, triggerNames);

if PARAMETERS.runICA == 1
%ERP ICA clean - load ERP, add weights, clean
end

%Run standard artificact rejection
[ ALLEEG, EEG, CURRENTSET, numGenFails, meanHEOG ] = standardArtRej( ALLEEG, EEG, CURRENTSET, currentFile );

%Extract conditions
extractConditions(ALLEEG, EEG, CURRENTSET, currentFile, triggerNames);

%Write processing stats to output file
IndividualInfo = writeIndvOutput( currentFile, badChannels, epochNum, horizFails, numGenFails, meanHEOG);

end

