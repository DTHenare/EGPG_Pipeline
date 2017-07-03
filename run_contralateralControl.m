%Pop up the file explorer for the user to select their study file
[studyFile,studyFolder] = uigetfile({'*.*',  'All Files (*.*)'});
if (studyFolder == 0) & (studyFile == 0)
        error('Input file is not selected!')
end

eeglab;

%Load study
[STUDY ALLEEG] = pop_loadstudy('filename', studyFile, 'filepath', studyFolder);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

%Get necessary parameters

%Get contralateral design from user
[ contraDesign ] = getContraDesign(STUDY.condition);

%Perform contralateral control

%Save output