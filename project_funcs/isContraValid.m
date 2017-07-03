function [ isValid, errorMsg ] = isContraValid( contraDesign )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
isValid = true;
numberOfElements = numel(contraDesign);

test=0;
for i = 1:numberOfElements
    if isempty(contraDesign{i})
        test=test+1;
    end
    if test == numberOfElements
        isValid = false;
        errorMsg = 'You did not enter any information in the contralateral design box. Try again.';
    end
end



end