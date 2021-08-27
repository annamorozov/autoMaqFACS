function [sumTbl_allTestSets, sumTbl_allTestSets_mean, sumTbl_allTestSets_std] =...
    computeSubjectsPerformance(classif_filename, ROItype, isSave2cpFile, isF1, isSumSingleTestSetsOnly)

% To compute performance of generalization to a new subject (or any other new test set - not class)

if nargin < 4   % isF1
    isF1 = false;
end

if nargin < 5   % isSumSingleTestSetsOnly
    isSumSingleTestSetsOnly = false;
end

% Params for new subj
isGener2NewVid = false;
isGener2NewSubj = true;
isSumSingleTestSets = true;

isHoldoutValid = false; 
isHoldoutValidTest = false;

% Params for new test set
% isGener2NewVid = false;
% isGener2NewSubj = false;
% isSumSingleTestSets = true;

[~, resTblRows_singleTestSets] = sumKnnClassifResFile(classif_filename,...
    isGener2NewVid, isGener2NewSubj, isSumSingleTestSets,...
    isHoldoutValid, isHoldoutValidTest, isF1, isSumSingleTestSetsOnly);    % new version

isCVresCol = true;

sumTbl_allTestSets = [];

for i = 1:length(resTblRows_singleTestSets)
    if isF1
        [sumTbl_sorted, best3Rows] = sortResFolderTbls_F1_oneSet(resTblRows_singleTestSets{i},...
            ROItype, isCVresCol);
    else
        [sumTbl_sorted, best3Rows] = sortResFolderTbls_Sensitivity_oneSet(resTblRows_singleTestSets{i},...
            ROItype, isCVresCol);
    end
        
    sumTbl_allTestSets = [sumTbl_allTestSets; sumTbl_sorted];
end

if isF1
    sumTbl_allTestSets_mean = varfun(@nanmean,sumTbl_allTestSets(:,(1:end-1)),...
        'InputVariables',sumTbl_allTestSets.Properties.VariableNames(2:(end-1)));

    sumTbl_allTestSets_std = varfun(@nanstd,sumTbl_allTestSets(:,(1:end-1)),...
        'InputVariables',sumTbl_allTestSets.Properties.VariableNames(2:(end-1)));
else
    sumTbl_allTestSets_mean = varfun(@nanmean,sumTbl_allTestSets,...
        'InputVariables',sumTbl_allTestSets.Properties.VariableNames(2:end));

    sumTbl_allTestSets_std = varfun(@nanstd,sumTbl_allTestSets,...
        'InputVariables',sumTbl_allTestSets.Properties.VariableNames(2:end));
end


if isSave2cpFile
    cp = load(classif_filename);
    
    if isF1
        cp.perf_gener2NewSubj.sumTbl_f1_allTestSets      = sumTbl_allTestSets;
        cp.perf_gener2NewSubj.sumTbl_f1_allTestSets_mean = sumTbl_allTestSets_mean;
        cp.perf_gener2NewSubj.sumTbl_f1_allTestSets_std  = sumTbl_allTestSets_std;
    else
        cp.perf_gener2NewSubj.sumTbl_allTestSets      = sumTbl_allTestSets;
        cp.perf_gener2NewSubj.sumTbl_allTestSets_mean = sumTbl_allTestSets_mean;
        cp.perf_gener2NewSubj.sumTbl_allTestSets_std  = sumTbl_allTestSets_std;
    end
    
    save(classif_filename, '-struct', 'cp');
end