function run_combineConditionLabels()
%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end
%Load the file
load(strcat(dataFolder,dataFile));
userDecision = 1;
curData = Output;

while userDecision == 1
    %Ask the user which events will be combined
    [eventSelection, OK] = listdlg('promptstring','Select the events that you''d like to combine','ListString',curData.conditions);
    if OK==0
        error('You must select at least one event!')
    end
    combineLabels = curData.conditions(eventSelection);
    
    %Ask user for the new label name
    newLabel = inputdlg('Enter the new label name:' );
    
    %combine the data and return the new data set
    curData = combineConditionLabels( curData, newLabel, combineLabels );
    
    %ask if the user wants to do another combination
    userDecision = menu('Done! Would you like to combine another set of labels?','Yes','No');
end

%Save the new data set
Output = curData;
save([dataFolder 'combined' dataFile],'Output')
end