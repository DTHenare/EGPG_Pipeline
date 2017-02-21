function [ testOutcome ] = checkSetup_triggersEdited( dataFolder, EGPGPath )
%Checks whether the contents of the user's triggerNames.txt file have been
%edited from the default file given in the pipeline folder.
%Inputs:    dataFolder = folder path of the location of the user's
%           triggerNames.txt file
%           EGPGPath = folder path for the EGPG pipeline which holds the
%           default triggerNames.txt file which should have been edited
%Outputs:   testOutcome = 1 if the triggers have been edited, 0 if they
%           have not

%Open the user triggerNames.txt file and store contents in triggerNames
FID = fopen(strcat(dataFolder,'\triggerNames.txt'));
C = textscan(FID, '%s');
triggerNames = C{1,1};

%Open the default triggerNames.txt file and store contents in defaultNames
FID = fopen(strcat(EGPGPath,'\triggerNames.txt'));
C = textscan(FID, '%s');
defaultNames = C{1,1};

%Compare the default and user files and return test result
testOutcome = ~isempty(setdiff(triggerNames, defaultNames));

end

