function [ failedFiles ] = createStudySet(STUDY, ALLEEG, EEG, CURRENTSET, triggerNames, fileNames, dataFolder, EGPGPath )
%Create the study structure used for group analysis in eeglab
%Inputs:    STUDY = STUDY structure produced by eeglab
%           ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           triggeNames = cell array containing list of event names that
%           will be epoched
%           fileNames = cell array containing list of participant files
%           dataFolder = path to the user data folder
%Output:    failedFiles = vector of filename for those files that weren't
%           loaded into the study (because of missing conditions)

%Load parameter file
load(strcat(EGPGPath,'\project_docs\Parameters.mat'));
blMin = PARAMETERS.ERP.epochMin;

%Create the cell array required for the std_editset function
[ studyCells, failedFiles, acceptedFiles ] = createStudyDataArray(triggerNames, fileNames, dataFolder);

%Create study
[ STUDY, ALLEEG ] = std_editset( STUDY, ALLEEG, 'filename','Experiment-Study.study','filepath',strcat(dataFolder,'Output\'), 'resave', 'on','name','Experiment-STUDY','updatedat','off','commands',studyCells );

%precompute the new study design and save it
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [(blMin*1000) 0] });
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
[STUDY EEG] = pop_savestudy( STUDY, EEG, 'filename','Experiment-Study.study','filepath',strcat(dataFolder,'Output\'));
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

%Create output object with all data for stats analysis
conditions = STUDY.condition';
channelList = {STUDY.changrp(:).name};
Output = createOutputSheet( STUDY, ALLEEG, channelList, conditions );

%Save output data
save(strcat(dataFolder,'Output\defaultOutput.mat'),'Output')

%Create useful plots for time and electrode selection
createStudyOutput( STUDY, ALLEEG, triggerNames, acceptedFiles, dataFolder, blMin );

%Clear eeglab
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

end