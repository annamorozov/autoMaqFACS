function specificDBImgs = loadSpecificDBImgs(folderFullName, framesInd)
% Load specific images from databases

allDbImgs = loadDBImgs(folderFullName);
specificDBImgs = allDbImgs(:, framesInd);

clear 'allDbImgs';
