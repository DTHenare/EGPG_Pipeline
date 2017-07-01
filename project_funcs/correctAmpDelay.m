function [ALLEEG,EEG,CURRENTSET] = correctAmpDelay(ALLEEG, EEG, CURRENTSET, delaySize)
%Corrects trigger latencies to account for the netstation amp delay.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           delaySize = size of the timing delay in milliseconds
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Converts ms delay to sampling point delay
samplingRateFix = 1000/EEG.srate;
adjustedDelaySize = delaySize/samplingRateFix;

%Move trigger latencies by required number of data points
for i = 1:size(EEG.event,2)
    EEG.event(i).latency = EEG.event(i).latency + adjustedDelaySize;
end

end

