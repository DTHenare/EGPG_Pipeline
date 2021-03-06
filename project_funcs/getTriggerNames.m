function [ triggerNames ] = getTriggerNames(PARAMETERS, dataFolder, selectedFile)
%Loads one data file and pops up a list of all possible triggers for a user
%to select from. Returns a cell array holding hte names of their selected
%triggers.
%Inputs:    dataFolder = path to the data folder
%           selectedFile = name of the file to load
%Outputs:   triggerNAmes = cell array containing the list of selected
%           trigger names

%path of the current file
currentFile = strcat(dataFolder,selectedFile);

[path, file, fileExt]=fileparts(currentFile);

%load parameters
%load(strcat(EGPGPath,'\project_docs\Parameters.mat'));

if strcmp(fileExt,'.RAW')
    %Read in data from file
    [ Head, ~ ] = readegi(currentFile);
    %Save event codes in allTriggers
    allTriggers = cellstr(Head.eventcode);
    try
        defaultDINS = { 'DIN1' 'DIN2' 'DIN4' 'DIN8' };
        testFor300 = strcmp(sort(allTriggers), defaultDINS);
        if sum(testFor300) == 4
            allTriggers = { 'DIN1' 'DIN2' 'DIN3' 'DIN4' 'DIN5' 'DIN6' 'DIN7' 'DIN8' 'DIN9' 'DIN10' 'DIN11' 'DIN12' 'DIN13' 'DIN14' 'DIN15' };
        end
    catch
    end
elseif strcmp(fileExt,'.set')
    ALLEEG = [];
    EEG=[];
    EEG = pop_loadset('filename',strcat(file,fileExt),'filepath',strcat(path,'\'));
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    if PARAMETERS.amp == 300
        EEG.event=combineMultipleTriggers(EEG.event);
    end
    allTriggers = unique({EEG.event(:).type});
else
    error('cannot read events from this file type')
end

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

%Present list of triggers to the user for selection
[UserSelection, OK] = listdlg('promptstring','Select the triggers you''d like to epoch','ListString',allTriggers);
if OK==0
    error('you must select at least one event for epoching')
end

%store selected triggers in triggerNames
triggerNames = allTriggers(UserSelection);
end