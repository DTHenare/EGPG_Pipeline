%This script provides a user friendly wrapper for the EGPG pipeline. When
%run, it pops open a file explorer for the user to navigate to a data file.
%It then runs the pipeilne for all matching files within the selected
%folder. It also performs a number of checks on the data in order to check
%that everything has been set up appropriately.


try
    %Pop up the file explorer for the user to select their file
    [selectedFile,dataFolder] = uigetfile({'*.*',  'All Files (*.*)'});
    if (dataFolder == 0) & (selectedFile == 0)
        error('Input file is not selected!')
    end
    
    %Get path of pipeline folder
    EGPGPath = fileparts(mfilename('fullpath'));
    
    %Create list of files that will be processed
    [ fileNames,fileExt, segPresent ] = getMatchingFiles(strcat(dataFolder, selectedFile));
    
    %Open eeglab
    eeglab;
    %Set eeglab options
    pop_editoptions( 'option_storedisk', 1, 'option_savetwofiles', 1, 'option_saveversion6', 1, 'option_single', 0)
    
    %Check whether parameters are loaded
    if ~exist('PARAMETERS','var')
        defaultParams = 1;
        load(strcat(EGPGPath,'\project_docs\Parameters.mat'));
    else
        defaultParams = 0;
    end
    
    %Pop-up list of triggers for user selection
    [ triggerNames ] = getTriggerNames(PARAMETERS, dataFolder, selectedFile);
    
    %Ask for the size of the delay
    delaySize = inputdlg('Input the total timing delay (in ms)');
    delaySize = str2num(delaySize{1});
    if length(delaySize)>1
        error('You entered more than one value for the timing delay. Enter the total delay only.')
    end
    
    %Check setup is appropriate
    checkSetup( selectedFile);
    
    %Preprocess each file in the data folder
    for i = 1:size(fileNames,1)
        %Start a diary to capture command window text
        diaryName = char(strcat(dataFolder, 'Diary_', fileNames(i,1),  '.out'));
        diary(diaryName);
        
        % if running the last person, write the methods section
        if i == size(fileNames,1) && ~defaultParams
            fid = fopen([dataFolder '/Output/ProcessingInfo/Methods.txt'],'wt');
        elseif i == size(fileNames,1) && defaultParams
            nonMethods = fopen([dataFolder '/Output/ProcessingInfo/Methods.txt'],'wt');
            appendMethods(nonMethods, ['Methods could not be written. It looks like this was run using default parameters which are not be optimised for your data. Please contact me if you would like to use my pipeline: dionhenare@gmail.com '])
            fid = -1;
        else
            fid = -1;
        end
        
        %create path of current file
        currentFile = strcat(dataFolder,fileNames{i,1},fileExt);
        %Run pipeline
        [ ALLEEG,EEG,CURRENTSET,IndividualInfo ] = EGPGPipeline(ALLEEG, EEG, CURRENTSET, PARAMETERS, currentFile, EGPGPath, triggerNames, segPresent, delaySize, fid, defaultParams);
        %Add current file's output to the group data
        if ~defaultParams
            writeGroupOutput( currentFile, IndividualInfo, i, triggerNames, fileNames )
        end
        %clear eeglab
        STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
        
        %Turn off current diary
        diary off
    end
    
    try
        fclose(fid);
    catch
        try
            fclose(nonMethods);
        end
    end
    
    %Create the study!
    [ failedFiles ] = createStudySet(STUDY, ALLEEG, EEG, CURRENTSET, PARAMETERS, triggerNames, fileNames, dataFolder );
    if ~defaultParams
        save(strcat(dataFolder,'/Output/ProcessingInfo/participantsExcludedFromSTUDY.mat'),'failedFiles');
    end
    
catch MException
    clear EEG.data
    save('errorFile.mat')
    disp('Some kinda error stopped me!')
    clear PARAMETERS
end