function setupSumAUsGroupsFreqTbls(AusAnalysisDirCol, subjAuSumDir, groupSize, isSubjectsSum)

% The function creates and saves summary table of AUs groups frequencies 
% for all the training videos of the subject (or several subjects).

% isSubjectsSum - optional param

if nargin < 4   % isSubjectsSum
    isSubjectsSum = false;
end

subjAuGroupsFreqTbl = sumAUsGroupsFreqTbls(AusAnalysisDirCol, groupSize, isSubjectsSum);

if ~exist(subjAuSumDir, 'dir')
    mkdir(subjAuSumDir);
end

tblName = sprintf('subjAuGroupsFreqTbl_%d', groupSize);
matFileName = sprintf('%s.mat', tblName);
save(fullfile(subjAuSumDir, matFileName), 'subjAuGroupsFreqTbl');

