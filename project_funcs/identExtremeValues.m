function [ extremFails ] = identExtremeValues( EEG, minVoltage, maxVoltage )
%Identifies epochs which have extreme values (+/- 100 microvolts)
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%Outputs:   extremFails = list of numbers indicating the epochs which
%           failed

%Convert baseline start to milliseconds
blMin = EEG.xmin * 1000;

%baseline the data
EEG = pop_rmbase( EEG, [blMin 0]);

%Identify artifact epochs
[EEG, extremFails] = pop_eegthresh(EEG,1,[1:EEG.nbchan] ,minVoltage,maxVoltage,EEG.xmin,EEG.xmax,0,0);

end

