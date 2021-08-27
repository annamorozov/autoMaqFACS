function [fullEigfmFilePathList, fullEigfmFilePath_meanImgs] = generateFullEigfmFilePathList(caseTrainingDir, numTestSets)
% Generate the paths for full eigenfaces mfiles and for the images' mean
% mfile

fullEigfmFilePath_meanImgs = fullfile(caseTrainingDir, 'fullEigenfaces_meanImgs.mat');

fullEigfmFilePathList      = {};

for i = 1:numTestSets  
    fullEigfmFilePath = sprintf('%s\\fullEigenfaces_testSet_%d.mat', caseTrainingDir, i);
    fullEigfmFilePathList = [fullEigfmFilePathList, fullEigfmFilePath];
end

end