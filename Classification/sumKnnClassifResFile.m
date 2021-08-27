function [resTblRows_singleClasses, resTblRows_singleTestSets] = sumKnnClassifResFile(...
    filename, isGener2NewVid, isGener2NewSubj, isSumSingleTestSets,...
    isHoldoutValid, isHoldoutValidTest, isF1, isSumSingleTestSetsOnly)
% Each cell in the result resTblRows = result row for table of a target class
% classifier

% isGener2NewVid - optional param

resTblRows_singleClasses = {};
resTblRows_singleTestSets = {};

if nargin < 2 % isGener2NewVid
    isGener2NewVid = false;
end

if nargin < 3 % isGener2NewSubj
    isGener2NewSubj = false;
end

if nargin < 4 % isSumSingleTestSets
    isSumSingleTestSets = false;
end

if nargin < 5 % isHoldoutValid
    isHoldoutValid = false;
end

if nargin < 6 % isHoldoutValidTest
    isHoldoutValidTest = false;
end

if nargin < 7 % isF1
    isF1 = false;
end

if nargin < 8 % isSumSingleTestSetsOnly
    isSumSingleTestSetsOnly = false;
end

CVO_name = 'CVO';
if isGener2NewVid
    CVO_name = 'CVO_gener2NewVid';
elseif isGener2NewSubj
    CVO_name = 'CVO_gener2NewSubj';
end

[~,name,~] = fileparts(filename);
fileRes = load(filename);

[resSum_singleClasses, resSum_singleTestSets] = sumClassifPerfResFile(filename, isGener2NewVid,...
    isGener2NewSubj, isSumSingleTestSets, isHoldoutValid, isHoldoutValidTest, isF1, isSumSingleTestSetsOnly);

singleResInd = find(~cellfun(@isempty,resSum_singleClasses));

if isHoldoutValid
    fileRes = fileRes.cp;
elseif isHoldoutValidTest
    fileRes = fileRes.holdoutTestPerfRes;
end

if ~isSumSingleTestSetsOnly
    resTblRows_singleClasses = addResTblRows(resSum_singleClasses,...
        singleResInd, name, fileRes, CVO_name, isHoldoutValid, isHoldoutValidTest, isF1);
end

if isSumSingleTestSets && ~isempty(resSum_singleTestSets)
    for i = 1:length(resSum_singleTestSets)
        singleResInd = find(~cellfun(@isempty,resSum_singleTestSets{i}));
        
        resTblRows_singleTestSets{i} = addResTblRows(resSum_singleTestSets{i},...
            singleResInd, name, fileRes, CVO_name, isHoldoutValid, isHoldoutValidTest, isF1);
    end
end

end

function resTblRows = addResTblRows(resTblRows_singleClasses, singleResInd,...
    name, fileRes, CVO_name, isHoldoutValid, isHoldoutValidTest, isF1)
    for i = 1:length(singleResInd)
        tgtClassRes = resTblRows_singleClasses{singleResInd(i)};

        resStruct.testName              = {name};
        resStruct.nTestSets             = fileRes.(CVO_name).NumTestSets;
        resStruct.labels                = {tgtClassRes.sumSingleClass{1}.Labels};
        
        if ~(isHoldoutValid || isHoldoutValidTest)
            resStruct.subjNames             = {strjoin(fileRes.subjects,',')};
            resStruct.imgWidth              = fileRes.imgWidth; 
            resStruct.imgHeight             = fileRes.imgHeight;
            resStruct.reqExplVar            = fileRes.reqExplVar;
            
            if isfield(fileRes,'numNeighbors')  % this is a KNN classifier
                resStruct.numNeighbors          = fileRes.numNeighbors; 
                resStruct.distanceMetric        = {fileRes.distanceMetric};
            else % this is SVM
                resStruct.boxConstr   = fileRes.boxConstr;
                resStruct.kernelFunc  = {fileRes.kernelFunc};
                resStruct.kernelScale = fileRes.kernelScale;
            end
        end

        for j = 1:length(tgtClassRes.sumSingleClass)
            resStruct_perCtrlCase = resStruct;

            resStruct_perCtrlCase.targetClasses         = {tgtClassRes.sumSingleClass{j}.TgtClasses};
            resStruct_perCtrlCase.controlClasses        = {tgtClassRes.sumSingleClass{j}.CtrlClasses};

            if isfield(tgtClassRes,'sumSingleClass_experSet') && ~isempty(tgtClassRes.sumSingleClass_experSet)
                if isF1
                    resStruct_perCtrlCase.errorRate_ExperTest    = tgtClassRes.sumSingleClass_experSet{j}.ErrorRate;
                    resStruct_perCtrlCase.recall_ExperTest       = tgtClassRes.sumSingleClass_experSet{j}.Recall;
                    resStruct_perCtrlCase.precision_ExperTest    = tgtClassRes.sumSingleClass_experSet{j}.Precision;
                    resStruct_perCtrlCase.f1_ExperTest           = tgtClassRes.sumSingleClass_experSet{j}.F1;
                    resStruct_perCtrlCase.sampPerClass_ExperTest = {tgtClassRes.sumSingleClass_experSet{j}.SamplesPerClass};
                else
                    resStruct_perCtrlCase.errorRate_ExperTest   = tgtClassRes.sumSingleClass_experSet{j}.ErrorRate;
                    resStruct_perCtrlCase.Sensitivity_ExperTest = tgtClassRes.sumSingleClass_experSet{j}.Sensitivity;
                    resStruct_perCtrlCase.Specificity_ExperTest = tgtClassRes.sumSingleClass_experSet{j}.Specificity;
                end
            end

            if isF1   
                resStruct_perCtrlCase.errorRate_CV          = tgtClassRes.sumSingleClass{j}.ErrorRate;
                resStruct_perCtrlCase.recall_CV             = tgtClassRes.sumSingleClass{j}.Recall;
                resStruct_perCtrlCase.precision_CV          = tgtClassRes.sumSingleClass{j}.Precision;
                resStruct_perCtrlCase.f1_CV                 = tgtClassRes.sumSingleClass{j}.F1;
                resStruct_perCtrlCase.sampPerClass_CV       = {tgtClassRes.sumSingleClass{j}.SamplesPerClass};
            else
                resStruct_perCtrlCase.errorRate_CV          = tgtClassRes.sumSingleClass{j}.ErrorRate;
                resStruct_perCtrlCase.Sensitivity_CV        = tgtClassRes.sumSingleClass{j}.Sensitivity;
                resStruct_perCtrlCase.Specificity_CV        = tgtClassRes.sumSingleClass{j}.Specificity;
            end

            tblRow = struct2table(resStruct_perCtrlCase);

            resTblRows{j,i} = tblRow;
        end
    end
end


    
