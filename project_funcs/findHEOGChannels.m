function [ leftEye, rightEye ] = findHEOGChannels(EEG)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:EEG.nbchan
    if strcmp(EEG.chanlocs(i).labels,'E128')
        leftEye = i;
    elseif strcmp(EEG.chanlocs(i).labels,'E125')
        rightEye = i;
    end
end

end

