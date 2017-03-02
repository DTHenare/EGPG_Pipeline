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

%Import the selected file
[ALLEEG, EEG, CURRENTSET] = importEEGData( ALLEEG, EEG, CURRENTSET, currentFile );
%create list of triggers in the data
allTriggers = unique({EEG.event(:).type});
%clear the data
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

%Present list of triggers to the user for selection
[SELECTION, OK] = listdlg('ListString',allTriggers);

%store selected triggers in triggerNames
triggerNames = allTriggers(SELECTION);
end

