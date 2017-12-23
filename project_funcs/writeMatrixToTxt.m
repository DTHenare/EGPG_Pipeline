function [ o ] = writeMatrixToTxt( conditions, statsValues, fid)
%Writes a 2D matrix of values to a tab delimited text file.
%Inputs:    conditions = A cell array where each cell is one condition
%           label.
%           statsValues = 2D matrix of values that will be written to the
%           text file.
%           fid = File Id for the file that will be written to.

numCond = length(conditions);
N = size(statsValues,1);

for cond = 1:numCond-1
    fprintf(fid, '%s\t',conditions{cond});
end
fprintf(fid, '%s',conditions{numCond});
fprintf(fid, '\n');

%Add data
for pNum = 1:N
    for cond = 1:numCond-1
        fprintf(fid, '%s\t',num2str(round(statsValues(pNum,cond),2)));
    end
    fprintf(fid, '%s',num2str(round(statsValues(pNum,numCond),2)));
    fprintf(fid, '\n');
end

end

