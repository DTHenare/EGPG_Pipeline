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

%Create the cell array required for the std_editset function
[ studyCells, failedFiles, acceptedFiles ] = createStudyDataArray(triggerNames, fileNames, dataFolder);

%Create study
[ STUDY, ALLEEG ] = std_editset( STUDY, ALLEEG, 'filename','Experiment-Study.study','filepath',strcat(dataFolder,'Output\'), 'resave', 'on','name','Experiment-STUDY','updatedat','off','commands',studyCells );

%Create useful output
createStudyOutput( STUDY, ALLEEG, triggerNames, acceptedFiles, dataFolder, PARAMETERS.ERP.epochMin );

%Clear eeglab
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

end