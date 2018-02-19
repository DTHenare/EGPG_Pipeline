function [ data ] = jackKnifeData(data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

pre = data;
nSubj = size(data{1},3);
nCond = length(data);

for cond = 1:nCond
    for subj = 1:nSubj
        curExcl = setdiff(1:nSubj,subj);
        data{cond}(:,:,subj) = mean(pre{cond}(:,:,curExcl),3);
    end
end
end