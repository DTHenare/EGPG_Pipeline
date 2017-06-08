function [ combinedEvent ] = combineMultipleTriggers(event)
%combineMultipleTriggers takes EEG.event input and combines all triggers of
%same latency into new trigger and removes the redunant triggers
%   Detailed explanation goes here
%Loops through all the events contained in event
    deleteList = [];
    for i = 1: (size(event,2)-1),
        %Checks to see if the adjacent event has the same latency
        if abs(event(i).latency - event(i+1).latency)<0.000001,
            %if so then get names and combine them assuming DIN# name for
            %trigger
            firstNum =  str2num(event(i).type(4:size(event(i).type,2)));
            secondNum = str2num(event(i+1).type(4:size(event(i+1).type,2)));
            combinedNum = firstNum + secondNum;
            deleteList(end +1)=i;
            event(i+1).type = strcat('DIN',num2str(combinedNum));
        end
    end
    event(deleteList) = [];
    combinedEvent = event;
   
end


