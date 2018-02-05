%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%Ask the user which events will be combined
[eventSelection, OK] = listdlg('promptstring','Select the events that you''d like to combine','ListString',Output.conditions);
if OK==0
    error('you must select at least one event')
end

%Ask user for the new label name
newLabel = inputdlg('Enter the new label name:' );

