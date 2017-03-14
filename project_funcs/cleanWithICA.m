function [ ALLEEG, EEG, CURRENTSET, totalNumberOfFails ] = cleanWithICA( ALLEEG, EEG, CURRENTSET, ICAStruct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Import ICA data
EEG.icaweights = ICAStruct.icaweights;
EEG.icawinv = ICAStruct.icawinv;
EEG.icasphere = ICAStruct.icasphere;
EEG.icachansind = ICAStruct.icachansind;

%% Fit Dipoles for components
%C:\Program Files\MATLAB\R2013a\toolbox\eeglab13_1_1b\plugins\dipfit2.2\standard_BESA\
EEG = pop_dipfit_settings( EEG, 'hdmfile','standard_BESA.mat','coordformat','Spherical','mrifile','avg152t1.mat','chanfile','standard-10-5-cap385.elp','coord_transform',[-0.25423 0 -8.4081 0 0.0027253 0 8.5946 -10.9643 10.4963] ,'chansel',[1:EEG.nbchan] );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, 0);
EEG = pop_multifit(EEG,[],'threshold',100,'plotopt',{'normlen' 'on'});
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, 0);

%% Remove poorly fitted components (high residual variance dipoles)
rvFails=[];
rvThresh=15;
for dipNum=1:size(EEG.icaweights,1)
    if EEG.dipfit.model(1,dipNum).rv > (rvThresh/100)
        rvFails = [rvFails dipNum];
    end
end
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
if ~isempty(locFails)
    EEG = pop_subcomp( EEG, locFails, 0);
end


%% Output number of failed components
rvSize = size(rvFails,2);
locSize = size(locFails,2);
totalNumberOfFails = rvSize+locSize;
end

