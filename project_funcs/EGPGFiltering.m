function [ALLEEG, EEG, CURRENTSET, text] = EGPGFiltering(ALLEEG, EEG, CURRENTSET, filterValue, filterType)
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
    text = [' High pass filtered with a ' int2str(filterValue) 'Hz butterworth filter implemented in ERPLAB.'];
elseif filterType == 2
    EEG  = pop_basicfilter( EEG,  1:128 , 'Boundary', 'boundary', 'Cutoff',  filterValue, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  4, 'RemoveDC', 'on' );
    text = [' Low pass filtered with a ' int2str(filterValue) 'Hz butterworth filter implemented in ERPLAB.'];
elseif filterType == 3
    try
        EEG  = pop_basicfilter( EEG,  1:128 , 'Boundary', 'boundary', 'Cutoff', filterValue, 'Design', 'butter', 'Filter', 'bandpass', 'Order',  4, 'RemoveDC', 'on' );
        text = [' Band pass filtered between ' int2str(filterValue(1)) ' and ' int2str(filterValue(2)) 'Hz using a butterworth filter implemented in ERPLAB.'];
    catch
        try
            EEG = pop_eegfiltnew(EEG, filterValue(1), filterValue(2));
            text = [' Band pass filtered between ' int2str(filterValue(1)) ' and ' int2str(filterValue(2)) 'Hz using pop_eegfiltnew.'];
        catch
            EEG = pop_eegfilt( EEG, filterValue(1), filterValue(2), [], [0], 0, 0, 'fir1', 0);
            text = [' Band pass filtered between ' int2str(filterValue(1)) ' and ' int2str(filterValue(2)) 'Hz using pop_eegfilt.'];
        end
    end
else
    error('The filterType you selected is not valid. It must be either 1, 2, or 3.')
end
