function [ ALLEEG, EEG, CURRENTSET, IndividualInfo ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, PARAMETERS, currentFile, EGPGPath, triggerNames, segPresent, delaySize, fid, defaultParams)
%This function runs the entire EGPG preprocessing pipeline.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed
%           EGPGPath = path of the EGPG pipeline folder
%           triggeNames = cell array containing list of event names that
%           will be epoched
%           segPresent = A 1 or 0 indicating whether the participant's data
%           is segmented into many files(1) or not(0)
%           delaySize = size of the timing delay in milliseconds
%           fid = file ID for the methods file
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab
%           IndividualInfo = struct containing proessing statistics for
%           individuals

try
%Load parameter file
%load(strcat(EGPGPath,'\project_docs\Parameters.mat'));
%Load chanlocs
load(strcat(EGPGPath,'\project_docs\chanlocs.mat'));

%Create output folders and files
createOutputObjects( currentFile );

%Check that ICA is possible
%adjustMissing = isempty(which('ADJUST'));
sasicaMissing = isempty(which('SASICA'));
fieldtripMissing = isempty(which('ft_analysispipeline'));
eitherMissing = max([sasicaMissing fieldtripMissing]);

%Run ICA if parameters say to, and toolboxes are available otherwise assign
%outputs NaN
if PARAMETERS.runICA == 1 && ~eitherMissing
[ ICAStruct, ICAbadChannels, ICAepochNum ] = ICAPreprocess(ALLEEG, EEG, CURRENTSET, PARAMETERS, currentFile, EGPGPath, triggerNames, segPresent, delaySize, fid);
else
    ICAbadChannels = nan;
    ICAepochNum = nan;
end

%ERP preprocess
[ ALLEEG, EEG, CURRENTSET, badChannels, epochNum, horizFails, chanStruct ] = ERPPreprocess(ALLEEG, EEG, CURRENTSET, PARAMETERS, currentFile, EGPGPath, triggerNames, segPresent, delaySize, fid);

%Use ICA cleaning if parameters say to, otherwise assign outputs NaN
if PARAMETERS.runICA == 1 && ~eitherMissing
%ERP ICA clean - load ERP, add weights, clean
[ ALLEEG, EEG, CURRENTSET, numberCompsRejected ] = cleanWithICA( ALLEEG, EEG, CURRENTSET, ICAStruct, currentFile, fid, badChannels, chanStruct, PARAMETERS );
else
    numberCompsRejected = nan;
end

%Run standard artificact rejection
[ ALLEEG, EEG, CURRENTSET, numGenFails, meanHEOG ] = standardArtRej( ALLEEG, EEG, CURRENTSET, currentFile, fid );

%Rereference
%EEG = pop_reref( EEG, [56 99] ,'keepref','on');

%Extract conditions
epochsPerCond = extractConditions(ALLEEG, EEG, CURRENTSET, currentFile, triggerNames);

%Write processing stats to output file
if ~defaultParams
IndividualInfo = writeIndvOutput( currentFile, badChannels, epochNum, horizFails, numGenFails, meanHEOG, ICAbadChannels, ICAepochNum, numberCompsRejected, epochsPerCond);
end

catch IException
    save('internalError.mat')
    disp('Some kinda error stopped me!')
    clear PARAMETERS
end

end

