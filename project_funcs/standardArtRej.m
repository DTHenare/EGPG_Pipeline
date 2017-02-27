function [  EEG, numFails, meanHEOG ] = standardArtRej( EEG )
%identifies epochs which contain artifact and removes them.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Reject epochs with extreme values
[ extremFails ] = identExtremeValues( EEG );

%Create single list of all failed epochs
allFails = extremFails;

%Remove failed epochs

%create variable to output number of rejected epochs
numFails = length(allFails);
%create3 variabel to output mean HEOG activity
[ leftEye, rightEye ] = findHEOGChannels(EEG);
meanHEOG = mean(mean(EEG.data(leftEye,:,:)-EEG.data(rightEye,:,:)));

end

