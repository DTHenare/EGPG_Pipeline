function [ isValid, errorMsg ] = isContraValid( contraDesign )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Set validity to true
isValid = true;
errorMsg = 'Great! Your contralateral design looks good.';
%Get properties of contraDesign
numberOfElements = numel(contraDesign);
numberOfRows = size(contraDesign,1);

for i = 1:numberOfRows
    %Grab data for a row
    rowData = contraDesign(i,:);
    %Remove empty cells from the row
    rowData = rowData(~cellfun('isempty',rowData));
    %If there are 1 or 2 remaining cells, mark as invalid and return error
    if mod(length(rowData),3) ~= 0
        isValid = false;
        errorMsg = 'One of your rows is only partially completed. For each row you must either leave it blank or fill in all information. Try again.';
    end
end

%Remove empty cells from the design
withoutEmpty = contraDesign(~cellfun('isempty',contraDesign));
%If there's nothing left, mark as invalid and return error
if isempty(withoutEmpty)
    isValid = false;
    errorMsg = 'You did not enter any information in the contralateral design box. Try again.';
end

end