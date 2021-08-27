function [sumTbl_allTestSets, sumTbl_allTestSets_mean, sumTbl_allTestSets_std] = ...
    computeGenerSensPerSubj_singleClassifFile(filename, ROItype, isSave2cpFile, isF1)

if nargin < 4   % isF1
    isF1 = false;
end

isSaveInCVO = true;
isRestrictTestFrames = true;
organizeClassifPredicts(filename, isSaveInCVO, isRestrictTestFrames);

crossValidate_gener2NewSubj_file(filename);

% To compute performance of generalization to a new subject (or any other new test set - not class)
[sumTbl_allTestSets, sumTbl_allTestSets_mean, sumTbl_allTestSets_std] =...
    computeSubjectsPerformance(filename, ROItype, isSave2cpFile, isF1);