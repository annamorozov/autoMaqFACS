function figHandle = plotAUsFlow(AUsInFramesTbl, vidName, neutralFrames_GlobalIndx)
% Plot the AUs flow of a video (events as function of time)

% neutralFrames_GlobalIndx - optional param. The indices of the neutral
% frames to be included in the plot.

AUsColDict = initializeROIsAUsColDictionary();
yVal = -1;
map = {};

figHandle = figure;
for i = 2:(width(AUsInFramesTbl))
    bInd =logical(AUsInFramesTbl{:,i});
    x = AUsInFramesTbl.frameNum(bInd);
    
    colName = AUsInFramesTbl.Properties.VariableNames(i);
    map = getRelevantAUsMap(AUsColDict, colName);

    yVal = cell2mat(values(map,colName));
    y = repelem(yVal,length(x));
    
    plot(x,y,'*'); hold on;
end

if nargin > 2   % neutralFrames_GlobalIndx
    x = neutralFrames_GlobalIndx;
    y = repelem(0,length(x));
    
    plot(x,y,'*'); hold on;
end 

titleStr = sprintf('AUs flow for video %s', vidName);
title(titleStr, 'FontSize', 14, 'Interpreter', 'none'); % set title

hold off;