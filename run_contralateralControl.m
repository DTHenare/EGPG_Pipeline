%Pop up the file explorer for the user to select their study file
[studyFile,studyFolder] = uigetfile('*.study', 'Select a study file');
if (studyFolder == 0) & (studyFile == 0)
        error('Input file is not selected!')
end

eeglab;

%Load study
[STUDY ALLEEG] = pop_loadstudy('filename', studyFile, 'filepath', studyFolder);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

%Get necessary parameters

%Get contralateral design from user
f = getContraDesign(STUDY.condition);
uiwait(f)

%Check that the contraDesign is valid
[isValid, reasonFailed ] = isContraValid( userData );
if ~isValid
    disp(reasonFailed)
else


%Perform contralateral control

%Save output
end