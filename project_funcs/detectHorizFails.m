function [ list, numFails ] = detectHorizFails( EEG, horizThresh )
%Checks all epochs and returns a list of epochs which contain excessive
%horizontal eye movements.
%Inputs:    EEG = EEG structure produced by eeglab
%           horizThresh = Threshold microvolt value above which a
%           horizontal eye movement is deemed excessive
%Outputs:   list - list of indices for those epochs which failed the test
%           and therefore have excessive eye movement (need to be rejected)
%           numFails = number of epochs which failed the test

numSamplesInEpoch = size(EEG.data,2);
numEpochs = size(EEG.data,3);
list = [];

%Find the channel index for the HEOGs
[ leftEye, rightEye ] = findHEOGChannels( EEG );

%Check each epoch and calculate a baseline value for each channel
for i = 1:numEpochs
    leftBaseline = calcTempBaseline(EEG, leftEye, i);
    rightBaseline = calcTempBaseline(EEG, rightEye, i);
    %Check whether any time point exceeds the HEOG threshold in this epoch
    for j = 1:numSamplesInEpoch
        leftEyeVoltage = EEG.data(leftEye,j,i)-leftBaseline;
        rightEyeVoltage = EEG.data(rightEye,j,i)-rightBaseline;
        horizDiff = abs(leftEyeVoltage - rightEyeVoltage);
        if horizDiff > horizThresh
            list = [list i];
            break;
        end
    end
end

%create variable to output the number of epochs which failed
numFails = length(list);

end