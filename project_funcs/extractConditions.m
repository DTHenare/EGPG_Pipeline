function [  ] = extractConditions(ALLEEG, EEG, CURRENTSET, currentFile)
%Separates a file into a set of conditions. Creates a separate file for
%each trigger name and saves to the OutputConditions folder.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed

%Get path information from current file
[ filePath, fileName, fileExt ] = fileparts(currentFile);

%Open the user triggerNames.txt file and store contents in triggerNames
FID = fopen(strcat(filePath,'\triggerNames.txt'));
C = textscan(FID, '%s');
triggerNames = C{1,1};

%create output folder if it doesn't already exist
saveLocation = strcat(filePath,'\OutputConditions\');
if ~exist(saveLocation, 'dir')
  mkdir(saveLocation);
end

for i = 1:length(triggerNames)
    EEG = pop_epoch( EEG,  triggerNames(i) , [EEG.xmin, EEG.xmax], 'newname', strcat(fileName,'-',triggerNames{i}), 'epochinfo', 'yes');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',strcat(saveLocation,fileName,'-',triggerNames{i},'.set'),'gui','off');
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0);
    EEG = eeg_checkset( EEG );
end

end

