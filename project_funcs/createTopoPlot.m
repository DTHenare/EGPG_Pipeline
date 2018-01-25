function [  ] = createTopoPlot( conditions, data, xAxis, elec, compLatencyms, compWidth, compWinMin, compWinMax, chanlocs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Start eeglab
eeglab;

numCond = length(conditions);
figure;

minY = 0;
maxY = 0;

%Plot each set of data to get info about y limits etc.
for cond = 1:numCond
    plotData = mean(data{cond}(:,elec,:),2);
    h = figure;
    plot(xAxis,mean(plotData(:,:,:),3),'linewidth', 2);
    
    yl = ylim;
    minY = min(minY,yl(1));
    maxY = max(maxY,yl(2));
    close(h)
end

%Plot the ERPs
for cond = 1:numCond
    ax(cond) = subplot(2,numCond,cond+numCond);
    plotData = mean(data{cond}(:,elec,:),2);
    ERPhand(cond) = plot(xAxis,mean(plotData(:,:,:),3),'linewidth', 2);
    
    %reapply automatic axis limits
    xlim(ax(cond),[-200,800])
    ylim(ax(cond),[minY,maxY])
    recX = compLatencyms - (compWidth/2);
    recY = minY;
    recWidth = compWidth;
    recHeight = abs(minY)+abs(maxY);
    
    %draw axis lines and line marking component of interest
    r = rectangle('Position', [ recX recY recWidth recHeight ], 'EdgeColor', [0.75 0.75 0.75], 'FaceColor', [0.75 0.75 0.75] );
    yline = line([0 0], [minY maxY], 'LineWidth', 2, 'Color', [0 0 0]);
    xline = line([-200 800], [0 0], 'LineWidth', 2, 'Color', [0 0 0]);
    
    %add title, axis labels, and legend
    title(conditions(cond))
    xlabel('Time(ms)')
    ylabel('Amplitude(µV)','linewidth', 2)
    %legend(ERPhand,conditions,'Location', 'southeast')
    %rearrange line stacking order so that ERPs are in front
    uistack([yline xline], 'bottom')
    uistack(r, 'bottom')    
end

%Create topo  plot data
for cond = 1:numCond
    curData = mean(data{cond}(compWinMin:compWinMax,:,:),1);
    curData = mean(curData,3);
    topoData(cond,:) = curData;
end

%get the min and max value of the topo data for plotting purposes
topoMin = mean(topoData(topoData==min(topoData(:))));
topoMax = mean(topoData(topoData==max(topoData(:))));

%Plot the topographies
for cond = 1:numCond
    subplot(2,numCond, cond)
    topoplot( topoData(cond,:), chanlocs, 'electrodes', 'ptslabels', 'maplimits', [ topoMin, topoMax ] );
end

%Plot grand average topo
figure
grandTopo = mean(topoData,1);
topoplot( grandTopo, chanlocs, 'electrodes', 'ptslabels', 'maplimits', [ topoMin, topoMax ] );

end

