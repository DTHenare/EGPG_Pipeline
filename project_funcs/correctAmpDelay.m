function [ALLEEG,EEG,CURRENTSET] = correctAmpDelay(ALLEEG, EEG, CURRENTSET)
%Corrects trigger latencies to account for the netstation amp delay.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

%Determines delay size based on sampling rate at recording
if EEG.srate == 1000
    delaySize = 8;
elseif EEG.srate == 500
    delaySize = 18;
elseif EEG.srate == 250
    delaySize = 36;
else delaySize = 0;

%Converts ms delay to sampling point delay
samplingRateFix = 1000/EEG.srate;
adjustedDelaySize = delaySize/samplingRateFix;

%move trigger latencies by required number of data points
for i = 1:size(EEG.event,2)
    EEG.event(i).latency = EEG.event(i).latency + adjustedDelaySize;
end

end

