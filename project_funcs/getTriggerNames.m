function [ triggerNames ] = getTriggerNames(dataFolder, selectedFile)
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

if strcmp(fileExt,'.RAW')
    %Read in data from file
    [ Head, ~ ] = readegi(currentFile);
    %Save event codes in allTriggers
    allTriggers = cellstr(Head.eventcode);
elseif strcmp(fileExt,'.set')
    EEG = pop_loadset('filename','LenoreData_Cleaned.set','filepath','C:\\Users\\dhen061\\Desktop\\New folder\\Output\\');
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    allTriggers = unique({EEG.event(:).type})
else
    error('cannot read events from this file type')
end

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

%Present list of triggers to the user for selection
[UserSelection, OK] = listdlg('ListString',allTriggers);
if OK==0
    error('you must select at least one event for epoching')
end

%store selected triggers in triggerNames
triggerNames = allTriggers(UserSelection);
end