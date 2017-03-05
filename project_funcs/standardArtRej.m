function [  ALLEEG, EEG, CURRENTSET, numFails, meanHEOG ] = standardArtRej(ALLEEG, EEG, CURRENTSET, currentFile )
%identifies epochs which contain artifact and removes them.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           currentFile = path of the input file
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab
%           numFails = number of epochs that were marked as bad
%           meanHEOG = average voltage of the HEOG

%Reject epochs with extreme values
[ extremFails ] = identExtremeValues( EEG );

%Create single list of all failed epochs
allFails = extremFails;

%Remove failed epochs
EEG = pop_rejepoch( EEG, allFails, 0);

%create variable to output number of rejected epochs
numFails = length(allFails);
%create variable to output mean HEOG activity
[ leftEye, rightEye ] = findHEOGChannels(EEG);
meanHEOG = mean(mean(EEG.data(leftEye,:,:)-EEG.data(rightEye,:,:)));

%% Save file
[filePath, fileName] = fileparts(currentFile);
saveLocation = strcat(filePath,'\Output\');
saveName = strcat(fileName,'_Cleaned');
[ ALLEEG, EEG ] = saveOutput(ALLEEG, EEG, CURRENTSET, saveLocation, saveName);

end