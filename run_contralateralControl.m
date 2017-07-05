%asks the user for a study file and allows them to perform contralateral
%control on the data in the study. The user specifies the contralateral
%design based on the conditions available in the study and outputs a .mat
%file which contains the double subtracted data.

%Pop up the file explorer for the user to select their study file
[studyFile,studyFolder] = uigetfile('*.study', 'Select a study file');
if (studyFolder == 0) & (studyFile == 0)
    error('Input file is not selected!')
end

eeglab;
close(gcf);

%Load study
[STUDY ALLEEG] = pop_loadstudy('filename', studyFile, 'filepath', studyFolder);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

%Get necessary parameters
channelList = {STUDY.changrp(:).name};
chanlocs = EEG(1,1).chanlocs;
conditions = STUDY.condition';
blMin = EEG(1,1).xmin*1000;

%Get contralateral design from user
f = getContraDesign(conditions);
uiwait(f)
pause(0.5);

%Check that the contraDesign is valid (userData is outputted from
%getContraDesign using assignin)
[isValid, reasonFailed ] = isContraValid( userData );
%If it's valid, then carry on, otherwise skip to the end and display why
if isValid
    %Get electrode pairs
    electrodePairs = createElectrodeList( chanlocs );
    
    %Create output object
    Output = createOutputSheet(STUDY, ALLEEG, channelList, conditions);
    
    %Perform contralateral control
    Output = doubleSubtraction(Output, userData, electrodePairs);
    
    %Save output
    save(strcat(studyFolder,'doubleSubOutput.mat'),'Output')
else
    disp(reasonFailed)
end

