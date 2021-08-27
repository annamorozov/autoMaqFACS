function setupSumSubjAUsFreqTbls(allSubjAuSumDir, subjAuSumDirCol)

% The function creates and saves summary table of AUs frequencies 
% for all the subjects.

allSubjAuFreqTbl = sumSubjAUsFreqTbls(subjAuSumDirCol);


if ~exist(allSubjAuSumDir, 'dir')
    mkdir(allSubjAuSumDir);
end


save(fullfile(allSubjAuSumDir, 'allSubjAuFreqTbl.mat'), 'allSubjAuFreqTbl');

