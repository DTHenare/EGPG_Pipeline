function [ samplepoint ] = convertMsToSamp( timepoint, baseline, samplingFreq )
%Converts a time point in ms into a sample point ie. the location of that 
%time point in an array 
%Inputs:    timepoint = The time in ms that will be converted.
%           baseline = The start of the baseline period in ms
%           samplingFreq = The current sampling frequency of the data
%Outputs:   samplepoint = the sample point that corresponds to the
%           timepoint inputted

samplingRate = 1000/samplingFreq;
samplepoint = (timepoint + abs(baseline))/samplingRate;
samplepoint = round(samplepoint);

end

