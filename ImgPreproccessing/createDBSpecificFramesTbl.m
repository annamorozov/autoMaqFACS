function specificFramesTbl_fromDB = createDBSpecificFramesTbl(folderFullName, framesInd)
% Create a table of specific images from DBs

% Outputs a table with the following columns:
% 'dbDir', 'frameInd', 'imgCell'
% imgCell - contains the img in a cell

specificDBImgs = loadSpecificDBImgs(folderFullName, framesInd);

dirNames    = cell(length(framesInd), 1);
dirNames(:) = {folderFullName};

nImgs = size(specificDBImgs,2);
imgCell = cell(nImgs, 1);
for i=1:nImgs
    imgCell{i} = specificDBImgs(:,i);
end

specificFramesTbl_fromDB = table(dirNames, framesInd, imgCell,...
    'VariableNames', {'dbDir', 'frameInd', 'imgCell'});