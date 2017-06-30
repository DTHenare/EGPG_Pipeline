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

%Load parameter file
load(strcat(EGPGPath,'\project_docs\Parameters.mat'));

%Create the cell array required for the std_editset function
k=1;
part=1;
for i = 1:length(fileNames)
    %Check that this participant has a file for every condition
    allFiles = 1;
    for j = 1:length(triggerNames)
        if exist(strcat(dataFolder,'Output\',fileNames{i},'-',triggerNames{j},'.set'), 'file') == 2
        else
            allFiles = 0;
        end
    end
    
    %If participant has all necessary files, add them to the study
    if allFiles == 1
        for j = 1:length(triggerNames)
            currentLoadPath = strcat(dataFolder,'Output\',fileNames{i},'-',triggerNames{j},'.set');
            studyCells{k} = { 'index', k, 'load', currentLoadPath, 'subject', fileNames{i}, 'condition', triggerNames{j}};
            k=k+1;
        end
    else
        failedFiles{part} = fileNames{i};
        part=part+1;
    end
end

%create study and save into the output folder
[STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'filename','Experiment-Study.study','filepath',strcat(dataFolder,'Output\'), 'resave', 'on','name','Experiment-STUDY','updatedat','off','commands',studyCells );

%% Create useful output
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [(PARAMETERS.ERP.epochMin*1000) 0] });
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
EEG = eeg_checkset( EEG );
[STUDY EEG] = pop_savestudy( STUDY, EEG, 'savemode','resave');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

channelList = {STUDY.changrp(:).name};

[ STUDY, allData, erpTimes ] = std_erpplot(STUDY,ALLEEG,'channels',channelList);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

save(strcat(dataFolder,'Output\STUDY-Output.mat'),'allData', 'erpTimes');

%% Clear eeglab
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

end