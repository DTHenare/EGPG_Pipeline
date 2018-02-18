eeglab
for i = [1,2,3,4,5,6,7,8,9,10,11,12,14,15,17,18,20,21,22]
    fileName = strcat('\\uoa.auckland.ac.nz\Shared\SCI\PSYC\PMCorballisLab\Archive\2012\Dion_Henare\EEG_Data\RAW_Files\Participant',int2str(i),'.RAW');

    EEG = pop_readegi(fileName, [],[],'auto');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');
    EEG = eeg_checkset( EEG );
    
    EEG.event = combineMultipleTriggers(EEG.event);
    
    for eventNum = 1:length(EEG.event)
        if strcmp(EEG.event(eventNum).type,'DIN15')
            EEG.event(eventNum+1).type = strcat('15',EEG.event(eventNum+1).type);
        elseif strcmp(EEG.event(eventNum).type,'DIN14')
            EEG.event(eventNum+1).type = strcat('14',EEG.event(eventNum+1).type);
        end
    end
    
    EEG = pop_saveset( EEG, 'filename',strcat('Participant',int2str(i),'.set'),'filepath','\\\\uoa.auckland.ac.nz\\Shared\\SCI\\PSYC\\PMCorballisLab\\Archive\\2012\\Dion_Henare\\EEG_Data\\RAW_Files\\setFiles_upperVlowerInfoAdded\\');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];

end