%Pop up the file explorer for the user to select their output file
[dataFile,dataFolder] = uigetfile('*.mat', 'Select an output file');
if (dataFolder == 0) & (dataFile == 0)
    error('Input file is not selected!')
end

%Create save file
[~, fileName, fileExt] = fileparts(dataFile);
saveFile = strcat(dataFolder, fileName, '.txt');
fid = fopen(saveFile,'wt');

%Open data and extract necessary values
Output = load(strcat(dataFolder,dataFile));
data = Output.Output.allData;
conditions = Output.Output.conditions;
numCond = length(conditions);
blMin = -200;
sampFreq = 250;
N = size(data{1,1},3);

%Get info from user
userInput = inputdlg({'Electrode Number','Component Latency (ms)', 'Component width (ms)', 'Use individual peaks? 1 = yes, 0 = no'},'Define electrode and time window',1);
elec = str2num(userInput{1});
compLatencyms = str2double(userInput(2));
compWidth = str2double(userInput(3));
indvPeaks = str2double(userInput(4));

%Check user input is usable

%Convert user values into data values
compWinMin = convertMsToSamp((compLatencyms-compWidth/2), blMin, sampFreq);
compWinMax = convertMsToSamp((compLatencyms+compWidth/2), blMin, sampFreq);

%Create values table
for cond = 1:numCond
    condValues = mean(data{cond}(compWinMin:compWinMax,elec,:),2);
    condValues = mean(condValues,1);
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
        fprintf(fid, '%s\t',num2str(round(dataValues(pNum,cond),2)));
    end
    fprintf(fid, '%s',num2str(round(dataValues(pNum,numCond),2)));
    fprintf(fid, '\n');
end

%Create output plots
xAxis = -200:4:792;
figure;
for cond = 1:numCond
    plotData = mean(data{cond}(:,elec,:),2);
    ERPhand(cond) = plot(xAxis,mean(plotData(:,:,:),3),'linewidth', 2);
    hold on
end
%reapply automatic axis limits
xlim auto
ylim auto
%extract automatic axis limits
xl = xlim;
yl = ylim;
%draw axis lines and line marking component of interest
h1 = line([compLatencyms compLatencyms], [yl(1) yl(2)], 'LineWidth', compWidth, 'Color', [0.75 0.75 0.75]);
h2 = line([0 0], [yl(1) yl(2)], 'LineWidth', 2, 'Color', [0 0 0]);
h3 = line([xl(1) xl(2)], [0 0], 'LineWidth', 2, 'Color', [0 0 0]);
%add title, axis labels, and legend
title('ERPs')
xlabel('Time(ms)')
ylabel('Amplitude(µV)','linewidth', 2)
legend(ERPhand,conditions,'Location', 'southeast')
%rearrange line stacking order so that ERPs are in front
uistack([h2 h3], 'bottom')
uistack(h1, 'bottom')