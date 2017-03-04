function [  ] = extractConditions(ALLEEG, EEG, CURRENTSET, currentFile, triggerNames)
%Separates a file into a set of conditions. Creates a separate file for
%each trigger name and saves to the OutputConditions folder.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the EEG file which will be processed
%           triggeNames = cell array containing list of event names that
%           will be epoched

%Get path information from current file
[ filePath, fileName ] = fileparts(currentFile);

%Find paths for saving everything
conditionsSaveLocation = strcat(filePath,'\Output\');

for i = 1:length(triggerNames)
    try
        EEG = pop_epoch( EEG, {  triggerNames{i}  }, [EEG.xmin EEG.xmax], 'newname', strcat(fileName,'-',triggerNames{i}), 'epochinfo', 'yes');
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',strcat(conditionsSaveLocation,fileName,'-',triggerNames{i},'.set'),'gui','off');
        EEG = eeg_checkset( EEG );
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0);
        EEG = eeg_checkset( EEG );
    catch
        disp(strcat('No remaining epochs have the event type: ', triggerNames{i}))
    end
end

end