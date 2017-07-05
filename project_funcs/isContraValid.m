function [ isValid, errorMsg ] = isContraValid( contraDesign )
%Runs a series of checks on a user's contralateral control design to snsure
%they've provided something that can be used to perform a double
%subtraction
%Inputs:    contraDesign = a cell array which holds the design that the
%           user entered
%Outputs:   isValid = boolean which returns whether the design has passed
%           the tests (true) or not (false)
%           errorMsg = a string which details why the design failed

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