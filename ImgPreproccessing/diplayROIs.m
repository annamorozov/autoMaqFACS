function img = diplayROIs(img, rectCellArray, lineWidthArray, colorArray)
% lineWidthArray, colorArray - optional params

for i=1:length(rectCellArray)
    rect = rectCellArray{i};
    
    if nargin == 2
        img = insertShape(img,'Rectangle',rect,'LineWidth',5);
    elseif nargin == 3 % lineWidthArray
        img = insertShape(img,'Rectangle',rect,'LineWidth',lineWidthArray(i));
    else % lineWidthArray, colorArray
        img = insertShape(img,'Rectangle',rect,'LineWidth',lineWidthArray(i),...
            'Color', colorArray{i});
    end 
end