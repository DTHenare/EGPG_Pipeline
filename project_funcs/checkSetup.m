function [  ] = checkSetup(dataFolder, EGPGPath, selectedFile)
%Checks to ensure the the user has set up the data folder and trigger file
%correctly in order to run the EGPG pipeline. Produces an error if anything
%looks wrong.
%Inputs:    dataFolder = Path of the folder which should hold all data that
%will run through the pipeline

%Check parameters file - present
checkSetup_parameters(EGPGPath);

%Check trigger file - present, has triggers, not default triggers
checkSetup_triggers(dataFolder, EGPGPath);

%Check input file - extension appropriate
checkSetup_datafile(selectedFile);

end

