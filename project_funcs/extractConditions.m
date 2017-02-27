function [  ] = extractConditions(ALLEEG, EEG, CURRENTSET, currentFile)
%Separates a file into a set of conditions. Creates a separate file for
%each trigger name and saves to the OutputConditions folder.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed

%Get path information from current file
[ filePath, fileName ] = fileparts(currentFile);

%Open the user triggerNames.txt file and store contents in triggerNames
FID = fopen(strcat(filePath,'\triggerNames.txt'));
C = textscan(FID, '%s');
triggerNames = C{1,1};

%Find paths for saving everything
conditionsSaveLocation = strcat(filePath,'\OutputConditions\');
wholeSaveLocation = strcat(filePath,'\Output\');
saveName = strcat(fileName,'_Cleaned');

for i = 1:length(triggerNames)
    
    EEG = pop_rmdat( EEG, {triggerNames(i)},[EEG.xmin EEG.xmax] ,0);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',strcat(conditionsSaveLocation,fileName,'-',triggerNames{i},'.set'),'saveold',strcat(wholeSaveLocation,saveName,'.set'),'gui','off');
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
end

end