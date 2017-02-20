function [ALLEEG,EEG,CURRENTSET] = correctAmpDelay(ALLEEG, EEG, CURRENTSET)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Determines delay size based on sampling rate at recording
if EEG.srate == 1000, 

%Determines delay in data points based on sampling rate
samplingRateFix = 1000/EEG.srate;
adjustedDelaySize = delaySize/samplingRateFix;

%moves trigger latency by required number of data points
for i = 1:size(EEG.event,2)
    EEG.event(i).latency = EEG.event(i).latency + adjustedDelaySize;
end

end

