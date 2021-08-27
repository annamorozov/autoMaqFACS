function setupSumAUsFreqHistograms(subjAuSumDir)

% The function creates and saves summary histogram of AUs 
% frequencies for all the training videos of the subject.

load(fullfile(subjAuSumDir, 'subjAuFreqTbl.mat'), 'subjAuFreqTbl');

titleStr = sprintf('Histogram of AUs from all videos for one monkey');
AuNamesList = subjAuFreqTbl.Properties.VariableNames;
AuFreqList = subjAuFreqTbl{1,:};
histHandle = getAUsFreqHistogram(AuNamesList, AuFreqList, titleStr);

figFileName = sprintf('subjAuFreqHist.fig');
saveas(histHandle, fullfile(subjAuSumDir, figFileName));



