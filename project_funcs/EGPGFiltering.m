function [ALLEEG, EEG, CURRENTSET] = EGPGFiltering(ALLEEG, EEG, CURRENTSET, filterValue, filterType)
%Filters eeglab data using the ERPLab filter function.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           filterValue = filter frequency parameters. Note: for filter type
%           is 1 or 2 this is a single value, for filter type 3 this is 2
%           values
%           filterType = Single value indicating which filter to run.
%                       1 - Highpass only
%                       2 - Lowpass only
%                       3 - Bandpass
%Outputs:   ALLEEG = updated ALLEEG structure for eeglab
%           EEG = updated EEG structure for eeglab
%           CURRENTSET = updated CURRENTSET value for eeglab

if filterType == 1
    EEG  = pop_basicfilter( EEG,  1:128 , 'Boundary', 'boundary', 'Cutoff',  filterValue, 'Design', 'butter', 'Filter', 'highpass', 'Order',  4, 'RemoveDC', 'on' );
elseif filterType == 2
    EEG  = pop_basicfilter( EEG,  1:128 , 'Boundary', 'boundary', 'Cutoff',  filterValue, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  4, 'RemoveDC', 'on' );
elseif filterType == 3
    EEG  = pop_basicfilter( EEG,  1:129 , 'Boundary', 'boundary', 'Cutoff', filterValue, 'Design', 'butter', 'Filter', 'bandpass', 'Order',  4, 'RemoveDC', 'on' );
else
    error('The filterType you selected is not valid. It must be either 1, 2, or 3.')
end
