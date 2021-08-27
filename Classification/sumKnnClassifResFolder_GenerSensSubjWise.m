function sumDirTbl_GenerSensSubjWise = sumKnnClassifResFolder_GenerSensSubjWise(resDir,...
    ROItype, isSave2cpFile, isGenerateNewCVpart)

% isGenerateNewCVpart - optional param. False by default (meaning that the
%                       original CV partition is already subject-wise in the test sets).
%                       If true, the data should be repartitioned before
%                       the calculation.

if nargin < 4
    isGenerateNewCVpart = false; 
end

filesList = dir(fullfile(resDir, 'nPC*.mat'));

sumDirTbl_GenerSensSubjWise = [];
testNames = {};

fprintf('Going to generate KNN sumDirTbl_GenerSensSubjWise for dir %s...\n', resDir);

for i = 1:length(filesList)
    filename = fullfile(filesList(i).folder, filesList(i).name);
    
    if isGenerateNewCVpart
        [~, sumTbl_allTestSets_mean, ~] = ...
            computeGenerSensPerSubj_singleClassifFile(filename, ROItype, isSave2cpFile);
    else
        % To compute performance of generalization to a new subject (or any other new test set - not class)
        [sumTbl_allTestSets, sumTbl_allTestSets_mean, sumTbl_allTestSets_std] =...
            computeSubjectsPerformance(filename, ROItype, isSave2cpFile);
    end
    
    sumDirTbl_GenerSensSubjWise = [sumDirTbl_GenerSensSubjWise; sumTbl_allTestSets_mean];
    testNames = [testNames; filesList(i).name];
end

sumDirTbl_GenerSensSubjWise.testName = testNames;

sumDirTbl_GenerSensSubjWise = sortrows(sumDirTbl_GenerSensSubjWise, 'nanmean_sensAvg', 'descend');
