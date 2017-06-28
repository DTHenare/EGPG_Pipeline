function [ epochAble ] = isEpochingAppropriate(EEG, triggerNames)
%Runs a number of checks on the data in order to determine whether the data
%should be epoched before ICA is run, or whetehr it should remain
%continuous.
%Inputs:    EEG = EEG structure produced by eeglab.
%Outputs:   epochAble = a 1 or a 0 indicating whether the data sould be
%epoched (1), or not (0).

%Check how many epochs will be created
eventNames = {EEG.event(:).type};
epochsForConds = cellfun(@(x) sum(ismember(eventNames,x)),triggerNames,'un',0);
epochNum = sum(cell2mat(epochsForConds));

%Calculate how many data points you'll have
sampAdj = 1000/EEG.srate;
numberOfms = epochNum * 3000;
numberOfSamples = numberOfms/sampAdj;

%Check whether number of data points is sufficient
targetDataPoints = EEG.nbchan^2*20;
if numberOfSamples >= targetDataPoints
    sufficientDataPoints = 1;
else
    sufficientDataPoints = 0;
end

%Check whether there is enough space for 3 second epochs
j=1;
for i = 1:size(EEG.event,2)
    if sum(strcmp({EEG.event(i).type},triggerNames))>0
        triggerTimes(j) = EEG.event(i).latency;
        j=j+1;
    end
end

%What proportion of the triggers don't have 3 seconds of space
numberOfFails = 0;
for i = 1:(size(triggerTimes,2)-1)
    if (triggerTimes(i+1)-triggerTimes(i)) < 3000
        numberOfFails = numberOfFails+1;
    end
end

%If more than 5% of triggers don't have 3 seconds space, return fail
if numberOfFails >= (epochNum*0.05)
    sufficientSpace = 0;
else
    sufficientSpace = 1;
end

%If there is enough data and space between triggers, return epochAble
if sufficientDataPoints && sufficientSpace
    epochAble = 1;
else
    epochAble = 0;
end