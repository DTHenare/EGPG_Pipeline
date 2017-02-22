function [ list ] = detectHorizFails( EEG, horizThresh )
%function description
%

numSamplesInEpoch = size(EEG.data,2);
numEpochs = size(EEG.data,3);
list = [];

%Find the channel index for the HEOGs
for i = 1:EEG.nbchan
    if strcmp(EEG.chanlocs(i).labels,'E128')
        leftEye = i;
    elseif strcmp(EEG.chanlocs(i).labels,'E125')
        rightEye = i;
    end
end

%Check each epoch and calculate a baseline value for each channel
for i = 1:numEpochs
    leftBaseline = mean(EEG.data(leftEye,1:(abs(EEG.xmin*EEG.srate)),i));
    rightBaseline = mean(EEG.data(rightEye,1:(abs(EEG.xmin*EEG.srate)),i));
    %Check whether any time point exceeds the HEOG threshold
    for j = 1:numSamplesInEpoch 
        if abs( (EEG.data(leftEye,j,i)-leftBaseline) - (EEG.data(rightEye,j,i)-rightBaseline) ) > horizThresh
            EEG.reject.rejmanual(i) =1;
            list = [list i];
            break;
        end
        
    end
end

end

%mean(mean(EEG.data(128,:,:)-EEG.data(125,:,:))) is code for calculating
%average of a participant's HEOG channel across all data in set