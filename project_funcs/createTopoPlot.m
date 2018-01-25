function [  ] = createTopoPlot( conditions, data, xAxis, elec, compLatencyms, compWidth )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

numCond = length(conditions);
figure;

minY = 0;
maxY = 0;

for cond = 1:numCond
    ax(cond) = subplot(2,numCond,cond+numCond);
    plotData = mean(data{cond}(:,elec,:),2);
    ERPhand(cond) = plot(xAxis,mean(plotData(:,:,:),3),'linewidth', 2);
    
    %reapply automatic axis limits
    xlim([-200,800])
    ylim auto
    %extract automatic axis limits
    xl = xlim;
    yl = ylim;
    
    ylim(ax(cond),[yl(1),yl(2)])
    recX = compLatencyms - (compWidth/2);
    recY = yl(1);
    recWidth = compWidth;
    recHeight = abs(yl(1))+abs(yl(2));
    
    %draw axis lines and line marking component of interest
    r(cond) = rectangle('Position', [ recX recY recWidth recHeight ], 'EdgeColor', [0.75 0.75 0.75], 'FaceColor', [0.75 0.75 0.75] );
    l1(cond) = line([0 0], [yl(1) yl(2)], 'LineWidth', 2, 'Color', [0 0 0]);
    l2(cond) = line([xl(1) xl(2)], [0 0], 'LineWidth', 2, 'Color', [0 0 0]);
    
    %add title, axis labels, and legend
    title('ERPs')
    xlabel('Time(ms)')
    ylabel('Amplitude(µV)','linewidth', 2)
    %legend(ERPhand,conditions,'Location', 'southeast')
    %rearrange line stacking order so that ERPs are in front
    uistack([l1(cond) l2(cond)], 'bottom')
    uistack(r(cond), 'bottom')
    
    minY = min(minY,yl(1));
    maxY = max(maxY,yl(2));
    
end

for cond = 1:numCond
    ylim(ax(cond),[minY,maxY])
    recX = compLatencyms - (compWidth/2);
    recY = minY;
    recWidth = compWidth;
    recHeight = abs(minY)+abs(maxY);
    
    rectangle(r(cond),'Position', [ recX recY recWidth recHeight ], 'EdgeColor', [0.75 0.75 0.75], 'FaceColor', [0.75 0.75 0.75] );
    line(l1(cond), [0 0], [minY maxY], 'LineWidth', 2, 'Color', [0 0 0]);
    line(l2(cond),[xl(1) xl(2)], [0 0], 'LineWidth', 2, 'Color', [0 0 0]);
end

end

