function [  ] = checkSetup_parameters(EGPGPath)
%Checks to ensure that the Parameters.mat file is present. Returns an error
%messages if the file is missing from its expected location
%Inputs:    EGPGPath = path to the EGPG pipeline folder 

if exist(strcat(EGPGPath,'\project_docs\Parameters.mat'), 'file') ~= 2
    error('There is no Parameters.mat file in the pipeline folder. IF you have moved it, place it back in the project_docs folder. If you cannot find it, then you need to download the pipeline folder again.')
end


end

