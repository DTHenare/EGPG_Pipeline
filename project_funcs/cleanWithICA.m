function [ ALLEEG, EEG, CURRENTSET, totalNumberOfFails ] = cleanWithICA( ALLEEG, EEG, CURRENTSET, ICAStruct, currentFile, fid, badChannels )
%Automatically detects and removes artifact ICA components using a number
%of criteria.
%Inputs:    ALLEEG = ALLEEG structure produced by eeglab
%           EEG = EEG structure produced by eeglab
%           CURRENTSET = CURRENTSET value provided by eeglab
%           ICAStruct = Struct containing component weights
%           currentFile = Full file path of the current participant file
%           fid = File ID for methods.txt
%Outputs:   ALLEEG = Updated ALLEEG structure for eeglab
%           EEG = Updated EEG structure for eeglab
%           CURRENTSET = Updated CURRENTSET value for eeglab
%           totalNumberOFFails = the number of components that were
%           rejected

%% Extract output path and filename
[ folderPath, fileName, ~ ] = fileparts(currentFile);

%% Import ICA data
EEG.icaweights = ICAStruct.icaweights;
EEG.icawinv = ICAStruct.icawinv;
EEG.icasphere = ICAStruct.icasphere;
EEG.icachansind = ICAStruct.icachansind;
appendMethods(fid, [' ICA weights were then copied over to this set of data in order to perform artifact correction.']);

if false
    %% Fit Dipoles for components
    %C:\Program Files\MATLAB\R2013a\toolbox\eeglab13_1_1b\plugins\dipfit2.2\standard_BESA\
    EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\Program Files\\MATLAB\\R2013a\\toolbox\\eeglab13_1_1b\\plugins\\dipfit2.2\\standard_BESA\\standard_BESA.mat','coordformat','Spherical','mrifile','C:\\Program Files\\MATLAB\\R2013a\\toolbox\\eeglab13_1_1b\\plugins\\dipfit2.2\\standard_BESA\\avg152t1.mat','chanfile','C:\\Program Files\\MATLAB\\R2013a\\toolbox\\eeglab13_1_1b\\plugins\\dipfit2.2\\standard_BESA\\standard-10-5-cap385.elp','coord_transform',[-0.25423 0 -8.4081 0 0.0027253 0 8.5946 -10.9643 10.4963] ,'chansel',[1:128] );
    [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, 0);
    EEG = pop_multifit(EEG,[],'threshold',100,'plotopt',{'normlen' 'on'});
    [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, 0);
    
    %% Remove poorly fitted components (high residual variance dipoles)
    rvFails=[];
    rvThresh=15;
    for dipNum=1:size(EEG.icaweights,1)
        if EEG.dipfit.model(1,dipNum).rv > (rvThresh/100)
            rvFails = [rvFails dipNum];
        end
    end
    %Remove identified components
    if ~isempty(rvFails)
        EEG = pop_subcomp( EEG, rvFails, 0);
    end
    
    %% Remove components with dipoles fitted outside of the head
    locFails=[];
    for dipNum=1:size(EEG.icaact,1)
        if any(sqrt(sum(EEG.dipfit.model(dipNum).posxyz.^2,2)) > 85)
            locFails = [ locFails dipNum];
        end
    end
    %Remove identified components
    if ~isempty(locFails)
        EEG = pop_subcomp( EEG, locFails, 0);
    end
    
    
    %% Output number of failed components
    rvSize = size(rvFails,2);
    locSize = size(locFails,2);
    totalNumberOfFails = rvSize+locSize;
end
totalNumberOfFails=[];
%% Reject with ADJUST
try
    %Remove bad channels if present
    if ~isempty(badChannels)
        EEG = pop_select( EEG,'nochannel',badChannels);
    end
    
    %Set output file location
    saveAdjust = strcat(folderPath,'\Output\ProcessingInfo\',fileName,'.txt');
    [ ADJUSTarts ] = ADJUST(EEG,saveAdjust);
    numADJUSTFails = length(ADJUSTarts);
    appendMethods(fid, [' The ADJUST toolbox was used in order to identify artifact components. All components identified as artifacts by ADJUST were removed from the data.']);
    
    %If any components have been identified as bad, reject them
    if ~isempty(ADJUSTarts)
        EEG = pop_subcomp( EEG, ADJUSTarts, 0);
    end
catch
    %If something fails, just set everything to 0 and carry on.
    ADJUSTarts = [];
    numADJUSTFails = 0;
end

%Calculate the total number of rejected components
totalNumberOfFails = totalNumberOfFails + numADJUSTFails;
end

