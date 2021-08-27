function setupSumAUsGroupsHistograms(subjAuSumDir, groupSize, isSubjectsSum)

% The function creates and saves summary histogram of AUs groups
% frequencies for all the training videos of the subject (or several subjects).

% isSubjectsSum - optional param

if nargin < 3   % isSubjectsSum
    isSubjectsSum = false;
end

tblName = sprintf('subjAuGroupsFreqTbl_%d', groupSize);
matFileName = sprintf('%s.mat', tblName);
load(fullfile(subjAuSumDir, matFileName), 'subjAuGroupsFreqTbl');

titleStr = sprintf('Histogram of each %d AUs from all videos for one monkey', groupSize);
if isSubjectsSum
    titleStr = sprintf('Histogram of each %d AUs from all videos from all monkeys', groupSize);
end

histHandle = getAUsGroupsHistogram(subjAuGroupsFreqTbl, titleStr);

figFileName = sprintf('subjAuGroupsFreqHist_%d.fig', groupSize);

if ~isempty(histHandle)
    saveas(histHandle, fullfile(subjAuSumDir, figFileName));
else
    fprintf('For this subject there were no groups of %d AUs.\n', groupSize);
end




