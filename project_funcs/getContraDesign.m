function [userData] = getContraDesign( conditionLabels )
%Create output variable place holder
userData = {};
%Define the sizes for padding, cell width, and cell height
spacer = 50;
cellWidth = 99;
cellHeight = 30;

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
userTableHeight = ceil(allTableHeight/2);
userTablePosX = spacer+allTableWidth+spacer;
userTablePosY = spacer+allTableHeight-userTableHeight;

%Define properties of text instructions
textWidth = allTableWidth + spacer + userTableWidth;
textHeight = cellHeight*2;
textPosX = allTablePosX;
textPosY = allTablePosY+allTableHeight;
textStr = 'Use the box on the right to define you contralateral control design. Type the event labels into the appropriate boxes and give each condition a name.';

%Define properties of the figure which will hold all objects
scrsz = get(groot,'ScreenSize');
figWidth = spacer + allTableWidth + spacer + userTableWidth + spacer;
figHeight = spacer + allTableHeight + textHeight + spacer;
figX = (scrsz(3)/2)-floor(figWidth/2);
figY = scrsz(4)/2;

%Create figure
f = figure('Name','Create the contralateral design',...
    'NumberTitle','off',...
    'MenuBar', 'none',...
    'Position',[figX figY figWidth figHeight]);

%Create text instructions
mTextBox = uicontrol('style','text',...
    'String',textStr,...
    'Position', [ textPosX textPosY textWidth textHeight ]);

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
ButtonH=uicontrol('Parent',f,'Style','pushbutton','String','Done','Position',[userTablePosX allTablePosY cellWidth cellHeight],'Units','pixels','Visible','on','Callback','close(gcf)');

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