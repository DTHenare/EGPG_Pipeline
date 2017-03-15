function [ALLEEG, EEG, CURRENTSET] = EGPGFiltering(ALLEEG, EEG, CURRENTSET, filterValue, filterType)
%Filters eeglab data using the ERPLab filter function. If ERPLab filter
%doesn't work, it trys to use the new eeglab filter. If that doesn't work,
%it uses the legacy eeglab filter.
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
    try
        EEG  = pop_basicfilter( EEG,  1:128 , 'Boundary', 'boundary', 'Cutoff', filterValue, 'Design', 'butter', 'Filter', 'bandpass', 'Order',  4, 'RemoveDC', 'on' );
    catch
        try
            EEG = pop_eegfiltnew(EEG, 0.1, 30);
        catch
            EEG = pop_eegfilt( EEG, 0.1, 30, [], [0], 0, 0, 'fir1', 0);
        end
    end
else
    error('The filterType you selected is not valid. It must be either 1, 2, or 3.')
end
