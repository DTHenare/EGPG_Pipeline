function [  ] = createERPPlot(conditions, data, xAxis, elec, compLatencyms, compWidth )
%Creates a plot of ERPs for a given set of conditions at a given electrode
%with the component of interest highlighted.
%Inputs:    conditions = A cell array where each cell is one condition
%           label.
%           data = A cell array where each cell is a 3D matrix of EEG
%           voltages (timepoints by electrodes by participants).
%           xAxis = vector of values to go along the x axis.
%           elec = Electrode number for data to be plotted.
%           compLatencyms = Latency of the component of interest.
%           compWidth = width of the component of interest.
numCond = length(conditions);
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
%Create component highlight
recX = compLatencyms - (compWidth/2);
recY = yl(1);
recWidth = compWidth;
recHeight = abs(yl(1))+abs(yl(2));

%draw axis lines and line marking component of interest
h1 = rectangle('Position', [ recX recY recWidth recHeight ], 'EdgeColor', [0.75 0.75 0.75], 'FaceColor', [0.75 0.75 0.75] );   
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

end