function [ statsValues ] = getStatsFromIndvWindow(data, conditions, compWinMin, compWinMax, elec, isNegative, indWin)
%Quantifies component amplitude by searching a predefined window for each
%individual's peak, and averaging the voltage from a small window around
%the individual peak.
%Inputs:    data = the ERP data in a cell array where each cell is one
%           condition and within each cell the data is arranged in a
%           timepoints by electrodes by participants.
%           conditions = A cell array where each cell is a string
%           representing the condition name for the data in the
%           corresponding data cell.
%           compWinMin = the sampling point which marks the start of the
%           averaging window.
%           compWinMax = the sampling point which marks the end of the
%           averaging window.
%           elec = The electrode number where the component will be
%           measured
%Outputs:   statsValues = a participant by condition matrix holding the
%           component amplitudes.

sampFreq = 250;
sampRate = sampFreq/1000;
%Get half of window length and round to nearest number of samples
halfSamp = round((indWin/2)/sampRate);

numCond = length(conditions);
numSubj = size(data{1},3);
statsValues  = zeros(numSubj,numCond);

if isNegative
    data = cellfun(@(x) times(x,-1),data, 'UniformOutput',false);
end

for subj = 1:numSubj
    for cond = 1:numCond
        condValues = mean(data{cond}(:,elec,subj),2);
         [ ~, indvPeak ] = findpeaks(condValues(compWinMin:compWinMax), 'SortStr', 'descend', 'NPeaks', 1);
        if isempty(indvPeak)
            [ ~, indvPeak ] = max(condValues(compWinMin:compWinMax));
        end
        indvPeak = indvPeak+compWinMin;
        condValues = mean(condValues(indvPeak-halfSamp:indvPeak+halfSamp,:,:),1);
        condValues = permute(condValues,[3,2,1]);
        statsValues(subj,cond) = condValues;
    end
end

end