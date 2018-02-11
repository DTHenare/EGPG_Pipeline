function [ statsValues ] = getStatsFromIndvWindow(data, conditions, compWinMin, compWinMax, elec, indWin)
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
sampRate = 1000/sampFreq;
%Get half of window length and round to nearest number of samples
halfSamp = round((indWin/2)/sampRate);

numCond = length(conditions);
numSubj = size(data{1},3);
statsValues  = zeros(numSubj,numCond);

%Calculate the mean voltage for the selected window and electrodes
windowMean = mean(mean(cat(4,data{:}),4),3);
windowMean = mean(mean(windowMean(compWinMin:compWinMax,elec)),2);

%If current component is negative, flip ERPs  (findpeaks finds positive
%peaks only)
if windowMean < 0
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

%If the component is negative, flip the values back to negative
if windowMean < 0
    statsValues = -statsValues;
end


end