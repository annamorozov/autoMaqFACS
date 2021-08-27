function runKnnClassifTests(resSaveDir, framesTblsPathList, imgSizePath, cvType, isComputeEigf, experSubjName,...
    samplesInd_global, samplesIndMat, framesTblsPathList_trainOnlyInd, subjToExclude,...
    isSkipFullEigenfCompute, isSkipExplVarEigfCompute, isSaveMdl,...
    isRestrictMinLblTrain, isRestrictMinLblTest)

% Run the classification process

% isComputeEigf - if true, the eigenfaces will be computed each time during
%                 runtime. Otherwise, they will be precomputed and loaded from the disc
%                 every time. 
% experSubjName, samplesIndMat, framesTblsPathList_trainOnlyInd - optional
% params
% isSkipFullEigenfCompute - true in case the full eigenfaces already
%                           computed and no need to compute them again
% isSkipExplVarEigfCompute - true in case the eigenfaces data already
%                            computed for different explained variances and
%                            no need to compute again

nPCsExplVarArr = [0.5, 0.53, 0.55, 0.57, 0.6, 0.63, 0.65, 0.67, 0.7, 0.73, 0.75, 0.8, 0.83, 0.85, 0.87, 0.9, 0.93, 0.95];   % 0 = "knee"
numNeighborsArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
distMetricArr = {'cosine', 'euclidean'};

fullTbl = [];
if nargin > 8 && ~isempty(framesTblsPathList_trainOnlyInd) &&...     % framesTblsPathList_trainOnlyInd, samplesIndMat
                 ~isempty(samplesIndMat)    
    fullTbl = loadFramesTblsList(framesTblsPathList, samplesIndMat,...
        framesTblsPathList_trainOnlyInd);
else
    fullTbl = loadFramesTblsList(framesTblsPathList);
end

if nargin < 10   % subjToExclude
    subjToExclude = '';
end

if nargin < 11  % isSkipFullEigenfCompute
    isSkipFullEigenfCompute = false;
end

if nargin < 12  % isSkipExplVarEigfCompute
    isSkipExplVarEigfCompute = false;
end

if nargin < 13  % isSaveMdl
    isSaveMdl = false;
end

if nargin < 14  % isRestrictMinLblTrain
    isRestrictMinLblTrain = false;
end

if nargin < 15  % isRestrictMinLblTest
    isRestrictMinLblTest = false;
end

%% CV partition
if strcmp(cvType, 'oneSubjOut') 
    if nargin > 5 && ~isempty(experSubjName)   % experSubjName
        CVO = getCvPartition_LeaveOneSubjOut(fullTbl.subjName, experSubjName);
    else
        if isRestrictMinLblTrain
            CVO = getCvPartition_LeaveOneSubjOut_Rhesus(fullTbl.subjName,...
                [], subjToExclude, fullTbl.label, isRestrictMinLblTest);
        else
            CVO = getCvPartition_LeaveOneSubjOut(fullTbl.subjName);
        end
    end
elseif strcmp(cvType, 'sameSubjOneVidOut')
    if isRestrictMinLblTrain
        CVO = getCvPartition_LeaveOneVidOut(fullTbl.trialName, fullTbl.subjName,...
            cvType, [], subjToExclude, fullTbl.label, isRestrictMinLblTest);
    else
        CVO = getCvPartition_LeaveOneVidOut(fullTbl.trialName, fullTbl.subjName,...
            cvType, samplesInd_global, subjToExclude);
    end
else
    error('Wrong cvType %s !', cvType);
end


% Save the source table info into the partition obj.
sourceTbl = fullTbl;
sourceTbl.imgCell = [];
CVO.sourceTbl = sourceTbl; 
CVO.cvType = cvType;

%% Compute eigenFaces for all test sets
load(imgSizePath, 'w', 'h');
if ~exist('w', 'var') || ~exist('h', 'var')
   error('Failed to load w and h from %s', imgSizePath); 
end

caseTrainingDir = fullfile(resSaveDir, 'trainingSetsEigf');
if ~exist(caseTrainingDir, 'dir')
    mkdir(caseTrainingDir);
end

% Save training indices
if nargin > 7 && ~isempty(samplesIndMat)   % samplesIndMat
    samplesFileName = fullfile(resSaveDir, 'samplesIndMat.mat');
    save(samplesFileName, 'samplesIndMat');
end

fullEigfmFilePathList = '';
fullEigfmFilePath_meanImgs = '';

if ~ isComputeEigf  % precomputed eigenfaces will be loaded from disc
    [fullEigfmFilePathList, fullEigfmFilePath_meanImgs] = generateFullEigfmFilePathList(caseTrainingDir, CVO.NumTestSets);
    explVarEigfmFilePath = fullfile(caseTrainingDir, 'explVarEigfData.mat');    % eigenfaces for certain explained variance
    
    if ~isSkipFullEigenfCompute
        [fullEigfmFilePathList, fullEigfmFilePath_meanImgs] = computeFullEigenfaces_forTestSets(CVO, fullTbl, w, h, caseTrainingDir);
    end
    
    if ~isSkipExplVarEigfCompute
        % Generate eigenfaces data for all requested expl. var.
        isShow = true;
        isCloseFigs = true;

        figsSaveDir = fullfile(caseTrainingDir, 'explVarEigf');
        if ~exist(figsSaveDir, 'dir')
            mkdir(figsSaveDir);
        end

        numTestSets = CVO.NumTestSets;

        for i = 1:numTestSets
            testSetInd = i;

            fullEigfmFilePath = fullEigfmFilePathList{testSetInd};
            
            generateExplVarEigfData_forTestSets(fullEigfmFilePath, fullEigfmFilePath_meanImgs, explVarEigfmFilePath, testSetInd, nPCsExplVarArr,...
                w, h, isShow, figsSaveDir, isCloseFigs);
        end
    end
else
    explVarEigfmFilePath = '';
end


%% Run the tests
for i = 1:length(nPCsExplVarArr)
    for j = 1:length(numNeighborsArr)
        for k = 1:length(distMetricArr)
            
            % Train and validate the KNN classifiers
            runKnnTest(resSaveDir, nPCsExplVarArr(i), numNeighborsArr(j), distMetricArr{:,k},...
                fullTbl, imgSizePath, CVO, isComputeEigf, fullEigfmFilePath_meanImgs, explVarEigfmFilePath, isSaveMdl);
            
        end
    end
end
