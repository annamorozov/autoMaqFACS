function setupSumKnnClassifRes_allTestSets_holdoutValid(classifResPath, isPeaks, validResDirName)

load(fullfile(classifResPath, 'trainingParams.mat'), 'setsResSaveDirList', 'nSets');

if nargin < 2   % isPeaks
    isPeaks = false;
end

if nargin < 3   % validResDirName
    validResDirName = 'validation_80_20';
end

if isPeaks
    setsResSaveDirList = strcat(setsResSaveDirList, '\validPks');
else
    setsResSaveDirList = strcat(setsResSaveDirList, sprintf('\\%s',validResDirName));
end

sortVar = '';
isGener2NewVid = false;
isGener2NewSubj = false;
isSumSingleTestSets = false;
isHoldoutValid = true;

sumKnnClassifRes_allTestSets(setsResSaveDirList, nSets, sortVar,...
    isGener2NewVid, isGener2NewSubj, isSumSingleTestSets, isHoldoutValid);