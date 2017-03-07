function [ STUDY, ALLEEG, EEG, CURRENTSET ] = createStudySet(STUDY, ALLEEG, EEG, CURRENTSET, triggerNames, fileNames, dataFolder )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

k=1;
for i = 1:length(fileNames)
    for j = 1:length(triggerNames)
        allFiles(k) = strcat(fileNames(i),'-',triggerNames(j),'.set');
        currentCell = {'index' k 'condition' triggerNames(j) 'subject' fileNames(i)};
        studyCells(k) = currentCell;
        k=k+1;
    end
end

EEG = pop_loadset('filename',allFiles,'filepath',strcat(dataFolder,'Output\'));
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'study',0);
%[STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);
[STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name','Experiment-STUDY','commands',studyCells,'updatedat','on','savedat','on' );
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

% 
% EEG = pop_loadset('filename',{'P23002-Stm4.set' 'P23002-Stm5.set' 'P23002-Stm6.set' 'P23002-Stm7.set' 'P23003-Stm4.set' 'P23003-Stm5.set' 'P23003-Stm6.set' 'P23003-Stm7.set' 'P23004-Stm4.set' 'P23004-Stm5.set' 'P23004-Stm6.set' 'P23004-Stm7.set' 'P23005-Stm4.set' 'P23005-Stm5.set' 'P23005-Stm6.set' 'P23005-Stm7.set' 'P23006-Stm4.set' 'P23006-Stm5.set' 'P23006-Stm6.set' 'P23006-Stm7.set' 'P23007-Stm4.set' 'P23007-Stm5.set' 'P23007-Stm6.set' 'P23007-Stm7.set' 'P23008-Stm4.set' 'P23008-Stm5.set' 'P23008-Stm6.set' 'P23008-Stm7.set' 'P23009-Stm4.set' 'P23009-Stm5.set' 'P23009-Stm6.set' 'P23009-Stm7.set' 'P23011-Stm4.set' 'P23011-Stm5.set' 'P23011-Stm6.set' 'P23011-Stm7.set' 'P23012-Stm4.set' 'P23012-Stm5.set' 'P23012-Stm6.set' 'P23012-Stm7.set' 'P23013-Stm4.set' 'P23013-Stm5.set' 'P23013-Stm6.set' 'P23013-Stm7.set' 'P23014-Stm4.set' 'P23014-Stm5.set' 'P23014-Stm6.set' 'P23014-Stm7.set' 'P23015-Stm4.set' 'P23015-Stm5.set' 'P23015-Stm6.set' 'P23015-Stm7.set' 'P23016-Stm4.set' 'P23016-Stm5.set' 'P23016-Stm6.set' 'P23016-Stm7.set' 'P23017-Stm4.set' 'P23017-Stm5.set' 'P23017-Stm6.set' 'P23017-Stm7.set' 'P23018-Stm4.set' 'P23018-Stm5.set' 'P23018-Stm6.set' 'P23018-Stm7.set' 'P23019-Stm4.set' 'P23019-Stm5.set' 'P23019-Stm6.set' 'P23019-Stm7.set'},'filepath','C:\\Users\\dhen061\\Google Drive\\sampleExpData\\Output\\');
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'study',0);
% [STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);
% [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name','Experiment-STUDY','commands',{{'index' 1 'condition' 'four'} {'index' 2 'condition' 'five'} {'index' 3 'condition' 'six'} {'index' 4 'condition' 'seven'} {'index' 3 'subject' 'P1'} {'index' 4 'subject' 'P1'} {'index' 5 'subject' 'P2'} {'index' 6 'subject' 'P2'} {'index' 7 'subject' 'P2'} {'index' 8 'subject' 'P2'} {'index' 5 'condition' 'four'} {'index' 9 'condition' 'four' 'subject' 'P3'} {'index' 10 'subject' 'P3'} {'index' 11 'subject' 'P3'} {'index' 12 'subject' 'P3'} {'index' 13 'subject' 'P4'} {'index' 14 'subject' 'P4'} {'index' 15 'subject' 'P4'} {'index' 16 'subject' 'P4'} {'index' 17 'subject' 'P5'} {'index' 18 'subject' 'P5'} {'index' 19 'subject' 'P5'} {'index' 20 'subject' 'P5'} {'index' 21 'subject' 'P6'} {'index' 22 'subject' 'P6'} {'index' 23 'subject' 'P6'} {'index' 24 'subject' 'P6'} {'index' 25 'subject' 'P7'} {'index' 26 'subject' 'P7'} {'index' 27 'subject' 'P7'} {'index' 28 'subject' 'P7'} {'index' 29 'subject' 'P8'} {'index' 30 'subject' 'P8'} {'index' 31 'subject' 'P8'} {'index' 32 'subject' 'P8'} {'index' 33 'subject' 'P9'} {'index' 34 'subject' 'P9'} {'index' 35 'subject' 'P9'} {'index' 36 'subject' 'P9'} {'index' 37 'subject' 'P10'} {'index' 38 'subject' 'P10'} {'index' 39 'subject' 'P10'} {'index' 40 'subject' 'P10'} {'index' 41 'subject' 'P11'} {'index' 42 'subject' 'P11'} {'index' 43 'subject' 'P11'} {'index' 44 'subject' 'P11'} {'index' 45 'subject' 'P12'} {'index' 46 'subject' 'P12'} {'index' 47 'subject' 'P12'} {'index' 48 'subject' 'P12'} {'index' 49 'subject' 'P13'} {'index' 50 'subject' 'P13'} {'index' 51 'subject' 'P13'} {'index' 52 'subject' 'P13'} {'index' 53 'subject' 'P14'} {'index' 54 'subject' 'P14'} {'index' 55 'subject' 'P14'} {'index' 56 'subject' 'P14'} {'index' 57 'subject' 'P15'} {'index' 58 'subject' 'P15'} {'index' 59 'subject' 'P15'} {'index' 60 'subject' 'P15'} {'index' 61 'subject' 'P16'} {'index' 62 'subject' 'P16'} {'index' 63 'subject' 'P16'} {'index' 64 'subject' 'P16'} {'index' 65 'subject' 'P17'} {'index' 66 'subject' 'P17'} {'index' 67 'subject' 'P17'} {'index' 68 'subject' 'P17'} {'index' 66 'condition' ''} {'index' 65 'condition' 'four'} {'index' 61 'condition' 'four'} {'index' 57 'condition' 'four'} {'index' 53 'condition' 'four'} {'index' 49 'condition' 'four'} {'index' 45 'condition' 'four'} {'index' 41 'condition' 'four'} {'index' 37 'condition' 'four'} {'index' 33 'condition' 'four'} {'index' 29 'condition' 'four'} {'index' 25 'condition' 'four'} {'index' 21 'condition' 'four'} {'index' 17 'condition' 'four'} {'index' 13 'condition' 'four'} {'index' 6 'condition' 'five'} {'index' 10 'condition' 'five'} {'index' 14 'condition' 'five'} {'index' 18 'condition' 'five'} {'index' 22 'condition' 'five'} {'index' 26 'condition' 'five'} {'index' 30 'condition' 'five'} {'index' 34 'condition' 'five'} {'index' 38 'condition' 'five'} {'index' 42 'condition' 'five'} {'index' 46 'condition' 'five'} {'index' 50 'condition' 'five'} {'index' 54 'condition' 'five'} {'index' 58 'condition' 'five'} {'index' 62 'condition' 'five'} {'index' 66 'condition' 'five'} {'index' 67 'condition' 'six'} {'index' 63 'condition' 'six'} {'index' 59 'condition' 'six'} {'index' 55 'condition' 'six'} {'index' 51 'condition' 'six'} {'index' 47 'condition' 'six'} {'index' 43 'condition' 'six'} {'index' 39 'condition' 'six'} {'index' 35 'condition' 'six'} {'index' 31 'condition' 'six'} {'index' 27 'condition' 'six'} {'index' 23 'condition' 'six'} {'index' 19 'condition' 'six'} {'index' 15 'condition' 'six'} {'index' 11 'condition' 'six'} {'index' 7 'condition' 'six'} {'index' 8 'condition' 'seven'} {'index' 12 'condition' 'seven'} {'index' 16 'condition' 'seven'} {'index' 20 'condition' 'seven'} {'index' 24 'condition' 'seven'} {'index' 28 'condition' 'seven'} {'index' 32 'condition' 'seven'} {'index' 36 'condition' 'seven'} {'index' 40 'condition' 'seven'} {'index' 44 'condition' 'seven'} {'index' 48 'condition' 'seven'} {'index' 52 'condition' 'seven'} {'index' 56 'condition' 'seven'} {'index' 60 'condition' 'seven'} {'index' 64 'condition' 'seven'} {'index' 68 'condition' 'seven'}},'updatedat','on','savedat','on' );
% CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
% 
% {'index' 9 'condition' 'four' 'subject' 'P3'}

end

