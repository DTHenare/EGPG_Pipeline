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
%eopn eeglab
eeglab;
%Create the input variables for importing
ALLEEG = [];
EEG = [];
CURRENTSET = 0;

%Read in data from file
[ Head, tempdata ] = readegi(currentFile);
%Save event codes in allTriggers
allTriggers = cellstr(Head.eventcode);

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

%Present list of triggers to the user for selection
[UserSelection, OK] = listdlg('ListString',allTriggers);
if OK==0
    error('you must select at least one event for epoching')
end

%store selected triggers in triggerNames
triggerNames = allTriggers(UserSelection);
end

