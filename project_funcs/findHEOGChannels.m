function [ leftEye, rightEye ] = findHEOGChannels(EEG)
%Searches through the EEG chanlocs structure to find the index of the
%channels which have the E125, and E128 labels
%Inputs:    EEG = EEG structure produced by eeglab
%Outputs:   leftEye = index of electrode 128
%           rightEye = index of electrode 125

for i = 1:EEG.nbchan
    if strcmp(EEG.chanlocs(i).labels,'E128')
        leftEye = i;
    elseif strcmp(EEG.chanlocs(i).labels,'E125')
        rightEye = i;
    end
end

end

