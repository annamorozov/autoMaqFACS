function [fullEigfmFilePathList, fullEigfmFilePath_meanImgs] = computeFullEigenfaces_forTestSets(CVO, framesTbl, imgWidth, imgHeight, caseTrainingDir)
% Compute the full eigenfaces for different sets

numTestSets = CVO.NumTestSets;

% Save and load with matfile, not to load all the struct array each time 
fullEigfmFilePathList      = {};

fullEigfmFilePath_meanImgs = fullfile(caseTrainingDir, 'fullEigenfaces_meanImgs.mat');

mFile_meanImgs = matfile(fullEigfmFilePath_meanImgs, 'Writable', true);

for i = 1:numTestSets    
    fprintf('trainKnnOnEigf: iter %d of %d...\n', i, numTestSets);
    
    % Get the training indices
    trIdx = CVO.training{i};
    
    thisTrTbl = framesTbl(trIdx, :);

    % Extract the images from the full table
    % Each column is an image
    thisTrImgs = horzcat(thisTrTbl.imgCell{:});
    
    fprintf('Going to compute full eigenfaces for test set %d...\n', i);

    isShow = false;
    saveDirInFunc = '';
    [meanImgVec, eigVectors, eigValues, nImgs, variancesMat] = computeFullEigenfaces(imgWidth, imgHeight, thisTrImgs,...
        isShow, saveDirInFunc);
    
    fprintf('Finished computing full eigenfaces for test set %d...\n', i);

    fullEigf.testSetInd   = i;
    fullEigf.eigVectors   = eigVectors;
    fullEigf.eigValues    = eigValues;
    fullEigf.nImgs        = nImgs;
    fullEigf.variancesMat = variancesMat;
    
    fullEigfmFilePath = sprintf('%s\\fullEigenfaces_testSet_%d.mat', caseTrainingDir, i);
    fullEigfmFilePathList = [fullEigfmFilePathList, fullEigfmFilePath];
    mFile = matfile(fullEigfmFilePath, 'Writable', true);
    
    mFile.fullEigenfaces = fullEigf;
    mFile_meanImgs.MeanImgs(i,1) = {meanImgVec};
end

end  