function [ALLEEG, EEG, CURRENTSET] = downsampleData( ALLEEG, EEG, CURRENTSET, targetRate )
%This function downsamples the data
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           targetRate - This is the sampling frequency that the data
%           will be changed to
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

if targetRate < EEG.srate
    EEG = pop_resample( EEG, targetRate);
else
    disp('Target sample rate is greater than or equal to the current sampling rate. Downsampling was not performed.')
end

end

