%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%Create save file
[~, fileName, fileExt] = fileparts(dataFile);
saveFile = strcat(dataFolder, fileName, '.txt');

%Open data and extract necessary values
Output = load(strcat(dataFolder,dataFile));
data = Output.Output.allData;
conditions = Output.Output.conditions;
numCond = length(conditions);
blMin = -200;
sampRate = 250;
N = size(data{1,1},3);

%Create output text file
fid = fopen(saveFile,'wt');

%Get info from user
userInput = inputdlg({'Electrode Number','Component Latency (ms)', 'Component width (ms)'},'Define electrode and time window',1);
elec = str2double(userInput(1));
compLatencyms = str2double(userInput(2));
compWidth = str2double(userInput(3));

%Check user input is usable

%Convert user values into data values
compLatencyms = compLatencyms+abs(blMin);
compWinMin = compLatencyms - (compWidth/2);
compWinMax = compLatencyms + (compWidth/2);
compWinMin = ceil(compWinMin/4);
compWinMax = floor(compWinMax/4);

%Create values table
for cond = 1:numCond
    condValues = mean(data{cond}(compWinMin:compWinMax,elec,:),1);
    condValues = mean(condValues,2);
    condValues = permute(condValues,[3,2,1]);
    dataValues(:,cond) = condValues;
end

%Write stats values to txt
%Add header with condition names
for cond = 1:numCond-1
    fprintf(fid, '%s\t',conditions{cond});
end
fprintf(fid, '%s',conditions{numCond});
fprintf(fid, '\n');

%Add data
for pNum = 1:N
    for cond = 1:numCond-1
        fprintf(fid, '%s\t',num2str(dataValues(pNum,cond)));
    end
    fprintf(fid, '%s',num2str(dataValues(pNum,numCond)));
    fprintf(fid, '\n');
end

%Create output plots
xAxis = -200:4:792;
figure;
plot(xAxis,mean(data{1}(:,elec,:),3),'linewidth', 2)
line([compLatencyms compLatencyms], [-1.5 1.5], 'LineWidth', 25, 'Color', [0.75 0.75 0.75])
line([0 0], [-1.5 1.5], 'LineWidth', 2, 'Color', [0 0 0])
line([-200 800], [0 0], 'LineWidth', 2, 'Color', [0 0 0])
hold on
for cond = 2:numCond
    plot(xAxis,mean(data{cond}(:,elec,:),3),'linewidth', 2)
end
title('ERPs')
xlabel('Time(ms)')
ylabel('Amplitude(µV)','linewidth', 2)
legend(conditions,'Location', 'southeast')