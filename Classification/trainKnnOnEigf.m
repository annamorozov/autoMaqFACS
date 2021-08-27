function [classifPerf_singleClasses, classifPerf_singleTestSets, CVO, mdlsArr] = trainKnnOnEigf(...
    cvPartition, framesTbl,...
    numNeighbors, distanceMetric, requestedExplVar,...
    isComputeEigf, fullEigfmFilePath_meanImgs, explVarEigfmFilePath,...
    imgWidth, imgHeight)

% Train and validate the KNN classifiers. The results will be saved to
% classperformance objects.

% isComputeEigf - true if the eigenfaces should be computed in the runtime.
%                 Otherwise, they will be loaded from precomputed files.
% imgWidth, imgHeight - optional params. Need to be passed in case of
%                       isComputeEigf == true.

% CVO is updated inside this function!!!

CVO = cvPartition;
numTestSets = CVO.NumTestSets;

%% Class pefrormance obj init

% Initialize the classperformance object using the true labels - target
% classes are the smaller AU classes
controlClasses = {'neutral_abs', 'AU_25_AU_26'};   
classifPerf_singleClasses = initClassifPerf4SpecificClasses(framesTbl.label,...
    controlClasses);

classifPerf_singleTestSets = {};
for i = 1:numTestSets
    classifPerf_singleTestSets{i} = initClassifPerf4SpecificClasses(framesTbl.label,...
        controlClasses);
end

% Initialize the classperformance object using the true labels - target
% classes are the biggest AUs
controlClasses = {'AU_1_2', 'AU_43', 'AU_25_AU_26_AU_16', 'AU_25_AU_26_AU_18i'};   
targetClasses  = {'AU_25_AU_26', 'neutral_abs'};

classifPerf_singleClasses(end+1) = initClassifPerf4SpecificClasses_ctrlCateg(framesTbl.label,...
    controlClasses, targetClasses);

for i = 1:numTestSets
    classifPerf_singleTestSets{i}(end+1) = initClassifPerf4SpecificClasses_ctrlCateg(framesTbl.label,...
        controlClasses, targetClasses);
end
%%

CVO.groundTruth = framesTbl.label;
CVO.nPCs = [];
CVO.skippedTestSets = [];

mdlsArr = {};

for i = 1:numTestSets    
    fprintf('trainKnnOnEigf: iter %d of %d...\n', i, numTestSets);
    
    weights = [];
    meanImgVec = [];
    eigVectors = [];
    
    % Get the training and testing indices
    trIdx = CVO.training{i};
    teIdx = CVO.test{i};
    
    thisTrTbl = framesTbl(trIdx, :);
    thisTeTbl = framesTbl(teIdx, :);
    
    % Extract the images from the full table
    % Each column is an image
    thisTeImgs = horzcat(thisTeTbl.imgCell{:});
    
    if ~isComputeEigf
        % Load eigenfaces data: from full eigenfaces
        if isempty(fullEigfmFilePath_meanImgs) || isempty(explVarEigfmFilePath)
            error('trainKnnOnEigf: Both fullEigfmFilePath_meanImgs and explVarEigfmFilePath should be provided!');
        end
        
        mFile_fullEigf_meanImgs = matfile(fullEigfmFilePath_meanImgs);
        meanImgVec = cell2mat(mFile_fullEigf_meanImgs.MeanImgs(i,1));

        % Load eigenfaces data: from eigenfaces for expl. var.
        mFile_explVarEigf = matfile(explVarEigfmFilePath);
        requestedExplVarVec = mFile_explVarEigf.requestedExplVarVec;
        iRow = i;
        iCol = find(int8(requestedExplVarVec*100) == int8(requestedExplVar*100));
        eigfData4ExplVar = mFile_explVarEigf.eigfData(iRow,iCol);
        
        if any(any(isnan(eigfData4ExplVar.eigVectors))) || isempty(eigfData4ExplVar.eigVectors)
           CVO.skippedTestSets = [CVO.skippedTestSets; i];
           fprintf('trainKnnOnEigf: iter %d of %d skipped...\n', i, numTestSets);
           continue;
        end

        eigVectors = eigfData4ExplVar.eigVectors;
        weights    = eigfData4ExplVar.weights;
    else
        % Estimate eigenfaces parameters
        if nargin < 10 || imgWidth == 0 || imgHeight == 0 % imgWidth, imgHeight
            error('trainKnnOnEigf: Both imgWidth and imgHeight should be provided!');
        end
        
        thisTrImgs = horzcat(thisTrTbl.imgCell{:});
        isShowEigFig = false;
        saveDir = '';
        isCloseFigs = true;
        
        [weights, meanImgVec, eigVectors, CVO.nPCs(i), ~] = eigenfacesAnalysis(imgWidth, imgHeight,...
            thisTrImgs, isShowEigFig, saveDir, isCloseFigs, requestedExplVar);
        
        if any(any(isnan(eigVectors))) || isempty(eigVectors)
           CVO.skippedTestSets = [CVO.skippedTestSets; i];
           fprintf('trainKnnOnEigf: iter %d of %d skipped...\n', i, numTestSets);
           continue;
        end
    end

    % Project the test image on the eigenfaces subspace
    probeFeatureMat = [];
    for j = 1:length(teIdx)
        % probeFeatureVec - column vector
        probeFeatureVec = projectProbeOnEigenSpace(thisTeImgs(:,j), meanImgVec, eigVectors);
        
        % each column is an image
        probeFeatureMat = [probeFeatureMat probeFeatureVec];
    end
    
    %reconstFrame = reconstructFeatureFromEigv(probeFeatureVec', eigVectors, meanImgVec, imgWidth, imgHeight);

    % Train KNN classifier: weight are the predictors, labels are the
    % response
    % Options that may be useful: 'ClassNames', 'Cost', 'PredictorNames', 
    %         'Distance' ('cosine', 'euclidean'...) 
    X = weights;    
    Y = thisTrTbl.label; 
    Mdl = fitcknn(X,Y,'NumNeighbors',numNeighbors, 'Distance', distanceMetric);
    mdlsArr{i} = Mdl;
    
    % Predict the classification of the testing image
    predictions = predict(Mdl,probeFeatureMat');
    CVO.classifPredictions{i} = predictions;
    
    %To save the probe:
    %CVO.probeFeatureMat{i} = probeFeatureMat;
    
    % After each cross-validation run, update the classifier performance object with the results
    for j = 1:length(classifPerf_singleClasses)
        classperf(classifPerf_singleClasses{j},     predictions, teIdx);
        classperf(classifPerf_singleTestSets{i}{j}, predictions, teIdx);
    end
end

end
