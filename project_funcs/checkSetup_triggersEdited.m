function [ testOutcome ] = checkSetup_triggersEdited( triggerNames, EGPGPath )
%Checks whether the triggerNames pulled from the user's file have been
%edited from the default file in the pipeline folder.
%Inputs:    triggerNames = Cell array containing the trigger names that
%           have been pulled from the users triggerNames.txt file
%           EGPGPath = folder path for the EGPG pipeline which holds the
%           default triggerNames.txt file which should have been edited
%Outputs:   testOutcome = 1 if the triggers have been edited, 0 if they
%           have not

%Open default triggerNames.txt file
FID = fopen(strcat(EGPGPath,'\triggerNames.txt'));
C = textscan(FID, '%s');
defaultNames = C{1,1};

%Compare the default and user files and return test result
testOutcome = ~isempty(setdiff(triggerNames, defaultNames));

end

