function [ ICAStruct, badChannels, epochNum ] = ICAPreprocess(ALLEEG, EEG, CURRENTSET, PARAMETERS, currentFile, EGPGPath, triggerNames, segPresent, delaySize, fid)
%Processes an EEG data set in a way which is optimal for the performance of
%independent components analysis
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
%           fid  = file ID for the methods file
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab
%           badChannels = vector containing the index of which electrodes
%           were identified as bad
%           epochNum = number of epochs generated by the preprocessing
%           procedure
%           horizFails = number of epochs which were removed because of
%           excessive eye movements

%Load parameters
%load(strcat(EGPGPath,'\project_docs\Parameters.mat'));

%Import data
[ALLEEG, EEG, CURRENTSET] = importEEGData( ALLEEG, EEG, CURRENTSET, currentFile, segPresent );

%Combine triggers if using 300amp
if PARAMETERS.amp == 300
    EEG.event=combineMultipleTriggers(EEG.event);
end

%Correct trigger latency
[ALLEEG, EEG, CURRENTSET] = correctAmpDelay( ALLEEG, EEG, CURRENTSET, delaySize );

%Downsample the data
[ALLEEG, EEG, CURRENTSET] = downsampleData( ALLEEG, EEG, CURRENTSET, PARAMETERS.ICA.downsampleRate );
appendMethods(fid, [' Data were downsampled to ' num2str(PARAMETERS.ICA.downsampleRate)  ' Hz.']);

%High pass filter the data
[ALLEEG, EEG, CURRENTSET, textFilterType, textFilterImpl ] = EGPGFiltering( ALLEEG, EEG, CURRENTSET, [ PARAMETERS.ICA.highpass PARAMETERS.ICA.lowpass], 3 );
appendMethods(fid, [' Data were' textFilterType ' filtered from ' num2str(PARAMETERS.ICA.highpass) ' to ' num2str(PARAMETERS.ICA.lowpass) ' using' textFilterImpl '.' ] );

%Load channel structure
EEG = pop_chanedit(EEG, 'load',{strcat(EGPGPath,'\project_docs\GSN-HydroCel-129.sfp') 'filetype' 'autodetect'},'setref',{'4:132' 'Cz'},'changefield',{132 'datachan' 0});
appendMethods(fid, [' Channel locations were loaded.']);

%Interpolate bad channels
[ALLEEG, EEG, CURRENTSET, badChannels] = fixBadChannels( ALLEEG, EEG, CURRENTSET );
appendMethods(fid, [' Bad channels were detected, removed, and replaced with a spherical interpolation of surrounding electrodes.']);

%Average reference the data
EEG = pop_reref( EEG, [],'refloc',struct('labels',{'Cz'},'Y',{0},'X',{5.4492e-16},'Z',{8.8992},'sph_theta',{0},'sph_phi',{90},'sph_radius',{8.8992},'theta',{0},'radius',{0},'type',{''},'ref',{'Cz'},'urchan',{132},'datachan',{0}));
appendMethods(fid, [' Data were then rereferenced to the average of all electrodes.']);

% Attempt to remove line noise using CleanLine
if false
    try
        EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:EEG.nbchan] ,'computepower',0,'linefreqs',[50 100] ,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',1,'sigtype','Channels','tau',100,'verb',1,'winsize',4,'winstep',4);
        appendMethods(fid, [' Line noise was removed using the CleanLine toolbox.']);
    catch
        appendMethods(fid, [' CleanLine toolbox either absent or failed, CleanLine was therefore not implemented.']);
    end
end

%% Check whether to epoch or run ICA on continuous
%[ epochAble ] = isEpochingAppropriate(EEG, EGPGPath, triggerNames);

if PARAMETERS.ICA.epochBeforeRUNICA
    %Epoch the events
    [ALLEEG, EEG, CURRENTSET, epochNum] = epochEvents( ALLEEG, EEG, CURRENTSET,  PARAMETERS.ICA.epochMin, PARAMETERS.ICA.epochMax, currentFile, triggerNames );
    appendMethods(fid, [' Data were then epoched from ' num2str(PARAMETERS.ICA.epochMin) ' prestimulus to ' num2str(PARAMETERS.ICA.epochMax) ' poststimulus.']);
    %identify bad epochs
    [ extremFails ] = identExtremeValues( EEG, -500, 500 );
    appendMethods(fid, [' Epochs containing gross artifact (+/-500 microvolts in any channel) were removed.']);
    %reject bad epochs
    EEG = pop_rejepoch( EEG, extremFails, 0);
    %Apply improbability test
    try
    EEG = pop_jointprob(EEG,1,[1:EEG.nbchan] ,6,2,0,1,0,[],0);
    appendMethods(fid, [' An improbability test was applied to the data and epochs which failed were removed.']);
    end
else
    %do continuous cleaning
    epochNum = [];
    appendMethods(fid, [' Data were not epoched in preparation for ICA (because there was an insufficient amount of data, or insufficient space between events, or both).']);
end

%% ICA
%Calculate data rank
dataRank = EEG.nbchan - (length(badChannels) + 1);

%run ICA
if PARAMETERS.ICA.numComponents >= dataRank
    EEG = pop_runica(EEG, 'extended',1,'interupt','on', 'pca', [dataRank]);
    EEG = eeg_checkset(EEG);
    appendMethods(fid, [' ICA was then performed on the data, using the PCA option to reduce dimensions to account for the number of interpolated channels.']);
else
    EEG = pop_runica(EEG, 'extended',1,'interupt','on', 'pca', PARAMETERS.ICA.numComponents);
    EEG = eeg_checkset(EEG);
    appendMethods(fid, [' ICA was then performed on the data, using the PCA option to reduce to ', num2str(PARAMETERS.ICA.numComponents), 'components.']);
end

%Save ICA weights to output variable
ICAStruct.icaweights = EEG.icaweights;
ICAStruct.icawinv = EEG.icawinv;
ICAStruct.icasphere = EEG.icasphere;
ICAStruct.icachansind = EEG.icachansind;
appendMethods(fid, [' ICA weights were then stored in order to be applied to data which had been preprocessed for the production of ERPs.\n']);
end

