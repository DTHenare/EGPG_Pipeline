function run_contralateralControl()
%asks the user for a study file and allows them to perform contralateral
%control on the data in the study. The user specifies the contralateral
%design based on the conditions available in the study and outputs a .mat
%file which contains the double subtracted data.

%Pop up the file explorer for the user to select their study file
[studyFile,studyFolder] = uigetfile('*.mat', 'Select the defaultOutput file.');
if (studyFolder == 0) & (studyFile == 0)
    error('Input file is not selected!')
end

%Load study
load([studyFolder studyFile])

%Get necessary parameters
channelList = Output.channelList;
chanlocs = Output.chanlocs;
conditions = Output.conditions;
blMin = Output.blMin;

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
    
    %Perform contralateral control
    Output = doubleSubtraction( Output, userData, electrodePairs );
    
    %Save output
    save([ studyFolder 'doubleSub' studyFile ],'Output');
else
    disp(reasonFailed)
end
end