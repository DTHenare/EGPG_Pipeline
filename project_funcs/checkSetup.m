function [  ] = checkSetup(dataFolder)
%Checks to ensure the the user has set up the data folder and trigger file
%correctly in order to run the EGPG pipeline. Produces an error if anything
%looks wrong.
%Inputs:    dataFolder = Path of the folder which should hold all data that
%will run through the pipeline

%Check parameters file - present

%Check trigger file - present, has triggers, not default triggers
checkSetup_triggers(dataFolder);

%Check input file - extension appropriate


end

