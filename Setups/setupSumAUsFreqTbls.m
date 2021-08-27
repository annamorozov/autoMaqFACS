function setupSumAUsFreqTbls(subjAuSumDir, AUsFramesTblsFileCol, ROItype)

% The function creates and saves summary table of AUs frequencies 
% for all the training videos of the subject.

% ROItype - optional param:
% 1 = upper face
% 2 = lower face

if nargin > 2   %ROItype
    subjAuFreqTbl = sumAUsFreqTbls(AUsFramesTblsFileCol, ROItype);
else
    subjAuFreqTbl = sumAUsFreqTbls(AUsFramesTblsFileCol);
end

if ~exist(subjAuSumDir, 'dir')
    mkdir(subjAuSumDir);
end

save(fullfile(subjAuSumDir, 'subjAuFreqTbl.mat'), 'subjAuFreqTbl');

