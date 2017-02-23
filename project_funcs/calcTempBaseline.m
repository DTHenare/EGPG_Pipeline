function [ baselineValue ] = calcTempBaseline(EEG, channelIndex, epochNumber)
%This function calculates the average value in a baseline period
%Inputs:    channelIndex = integer of the channel index for which the
%           baseline will be calculated
%           epochNumber = integer index of the epoch for which the baseline
%           will be calculated
%Output:    baselineValue = mean of the baseline period for the given
%           channel and epoch

%Calculate sampling points which define the baseline period
baselineStart = 1;
baselineEnd = abs(EEG.xmin*EEG.srate);

%Extract the vector which represents the voltages in the baseline period
baselineValues = EEG.data(channelIndex, baselineStart:baselineEnd, epochNumber);

%Calculate the average of this set of values
baslineValue = mean(baselineValues);

end

