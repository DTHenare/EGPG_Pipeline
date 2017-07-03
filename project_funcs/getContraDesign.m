function [userData] = getContraDesign( conditionLabels )
f=figure;
userData={};

%Define sizes for padding, cell width, and cell height
spacer = 50;
cellWidth = 99;
cellHeight = 50;

%Define properties of the table which displays possible triggers
allTableColName = {'PossibleTriggers'};
allOptionsData = conditionLabels';
allTableWidth = cellWidth*length(allTableColName)+2;
allTableHeight = cellHeight*length(allOptionsData);
allTablePosX = spacer;
allTablePosY = spacer;

%Define properties of the table which the user edits
userTableColName = {'Condition Name'; 'Left Event' ; 'Right Event'};
userTableData = cell(length(conditionLabels)/2,3);
userTableWidth = cellWidth*length(userTableColName)+2;
userTableHeight = cellHeight*3;
userTablePosX = spacer+allTableWidth+spacer;
userTablePosY = spacer+allTableHeight-userTableHeight;

%Create table which displays possible triggers
allOptions = uitable('Parent', f,...
    'Data', allOptionsData,...
    'Position', [allTablePosX allTablePosY allTableWidth allTableHeight],...
    'RowName',({}),...
    'ColumnWidth',{99},...
    'ColumnName',allTableColName,...
    'ColumnEditable', false);

%Create table which the user edits
userInput = uitable('Parent', f,...
    'Data', userTableData,...
    'Position', [userTablePosX userTablePosY userTableWidth userTableHeight],...
    'RowName',({}),...
    'ColumnWidth',{99 99 99},...
    'ColumnName',userTableColName,...
    'ColumnEditable', [true true true]);

%Create button which closes figure
ButtonH=uicontrol('Parent',f,'Style','pushbutton','String','Done','Position',[userTablePosX userTablePosY-userTableHeight 100 50],'Units','pixels','Visible','on','Callback','close(gcf)');

%Store data when user closes the figure
set(f,'CloseRequestFcn',@myCloseFcn)
set(f,'Tag', 'myTag')
set(userInput,'Tag','myTableTag')

function myCloseFcn(~,~)
%Stores data from the table when the figure is closed
myfigure=findobj('Tag','myTag');
myData = get(findobj(myfigure,'Tag','myTableTag'),'Data');
assignin('base','userData',myData)
delete(myfigure)
end

end