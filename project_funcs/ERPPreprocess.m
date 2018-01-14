function [ ALLEEG,EEG,CURRENTSET, badChannels, epochNum, horizFails, chanStruct ] = ERPPreprocess(ALLEEG, EEG, CURRENTSET, currentFile, EGPGPath, triggerNames, segPresent, delaySize, fid)
%Processes an EEG data set in a way which is optimal for the production of
%ERPs
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
%           fid = File ID for methods.txt
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
load(strcat(EGPGPath,'\project_docs\Parameters.mat'));

%Import data
[ALLEEG, EEG, CURRENTSET] = importEEGData( ALLEEG, EEG, CURRENTSET, currentFile, segPresent );

%Combine triggers if using 300amp
if PARAMETERS.amp == 300                              
    EEG.event=combineMultipleTriggers(EEG.event);
end

%Correct trigger latency
[ALLEEG, EEG, CURRENTSET] = correctAmpDelay( ALLEEG, EEG, CURRENTSET, delaySize );

%Downsample the data
[ALLEEG, EEG, CURRENTSET] = downsampleData( ALLEEG, EEG, CURRENTSET, PARAMETERS.ERP.downsampleRate );
appendMethods(fid, [' Data were downsampled to ' int2str(PARAMETERS.ERP.downsampleRate)  'Hz.']);

%High pass filter the data
[ALLEEG, EEG, CURRENTSET, filtText] = EGPGFiltering( ALLEEG, EEG, CURRENTSET, [ PARAMETERS.ERP.highpass PARAMETERS.ERP.lowpass], 3 );
appendMethods(fid, filtText);

%Load channel structure
EEG = pop_chanedit(EEG, 'load',{strcat(EGPGPath,'\project_docs\GSN-HydroCel-129.sfp') 'filetype' 'autodetect'},'setref',{'4:132' 'Cz'},'changefield',{132 'datachan' 0});
appendMethods(fid, [' Channel locations were loaded.']);

%Interpolate bad channels
[ALLEEG, EEG, CURRENTSET, badChannels, chanStruct] = fixBadChannels( ALLEEG, EEG, CURRENTSET );
appendMethods(fid, [' Bad channels were detected, removed, and replaced with a spherical interpolation of surrounding electrodes.']);

%Average reference the data
EEG = pop_reref( EEG, [],'refloc',struct('labels',{'Cz'},'Y',{0},'X',{5.4492e-16},'Z',{8.8992},'sph_theta',{0},'sph_phi',{90},'sph_radius',{8.8992},'theta',{0},'radius',{0},'type',{''},'ref',{'Cz'},'urchan',{132},'datachan',{0}));
appendMethods(fid, [' Data were then rereferenced to the average of all electrodes.']);

% Attempt to remove line noise using CleanLine
try
    EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:EEG.nbchan] ,'computepower',0,'linefreqs',[50 100] ,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',1,'sigtype','Channels','tau',100,'verb',1,'winsize',4,'winstep',4);
    appendMethods(fid, [' Line noise was removed using the CleanLine toolbox.']);
catch
end

%Epoch the events
[ALLEEG, EEG, CURRENTSET, epochNum] = epochEvents( ALLEEG, EEG, CURRENTSET,  PARAMETERS.ERP.epochMin, PARAMETERS.ERP.epochMax, currentFile, triggerNames );
appendMethods(fid, [' Data were then epoched from ' int2str(PARAMETERS.ERP.epochMin) ' prestimulus to ' int2str(PARAMETERS.ERP.epochMax) ' poststimulus.']);

%Detect HEOG failures
[ list, horizFails ] = detectHorizFails( EEG, PARAMETERS.horizThresh );
appendMethods(fid, [' Epochs containing horizontal eye movements were identified as any epoch containing a greater than 32 microvolt difference between electrodes location at the outer canthi of each eye.']);

%reject bad epochs
EEG = pop_rejepoch( EEG, list, 0);

end