function [ statsValues ] = getStatsFromGroupWindow(data, conditions, compWinMin, compWinMax, elec)
%Quantifies component amplitude by averaging the voltages in a defined
%window for all conditions. 
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
%                                    calculate component amplitudes.

numCond = length(conditions);
numSubj = size(data{1},3);
statsValues  = zeros(numSubj,numCond);
for cond = 1:numCond
    condValues = mean(data{cond}(compWinMin:compWinMax,elec,:),2);
    condValues = mean(condValues,1);
    condValues = permute(condValues,[3,2,1]);
    statsValues(:,cond) = condValues;
end

end

