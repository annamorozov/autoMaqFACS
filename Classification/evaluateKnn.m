function [classifPerf_singleClasses, classifPerf_singleTestSets, mdlsArr] = evaluateKnn(framesTbl, CVO, imgSizePath, resSavePath,...
    numNeighbors, distanceMetric, isComputeEigf, fullEigfmFilePath_meanImgs, explVarEigfmFilePath, requestedExplVar, isSaveMdl)

% Train and validate the KNN classifiers, save the results

load(imgSizePath, 'w', 'h');
if ~exist('w', 'var') || ~exist('h', 'var')
   error('Failed to load w and h from %s', imgSizePath); 
end

%% Parameters
imgWidth = w;
imgHeight = h;

if nargin <= 9   % requestedExplVar
    requestedExplVar = 0;
end

%% Training

[classifPerf_singleClasses, classifPerf_singleTestSets, CVO, mdlsArr] = trainKnnOnEigf(CVO, framesTbl,...
    numNeighbors, distanceMetric, requestedExplVar, isComputeEigf, fullEigfmFilePath_meanImgs, explVarEigfmFilePath,...
    imgWidth, imgHeight);



%% Res to save:
labels   = unique(framesTbl.label);
subjects = unique(framesTbl.subjName);

reqExplVar = 0;
if nargin > 9   % requestedExplVar
    reqExplVar = requestedExplVar;
end

if nargin < 11  % isSaveMdl
    isSaveMdl = false;
end

save(resSavePath, 'classifPerf_singleClasses', 'classifPerf_singleTestSets', 'subjects', 'labels', 'imgWidth', 'imgHeight', 'CVO',...
    'reqExplVar', 'numNeighbors', 'distanceMetric');

if isSaveMdl
    save(resSavePath, 'mdlsArr', '-append');
end
