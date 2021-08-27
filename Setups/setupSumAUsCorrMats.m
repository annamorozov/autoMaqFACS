function setupSumAUsCorrMats(AUsFramesTblsFileCol, subjAuSumDir, isShow, isSubjectsSum, colNames)

% The function creates and saves summary table of all AUs in frames of all
% videos, and also creates and saves their correlation matrix (and optionally its figure)

% isSubjectsSum - optional param
% colNames - optional params (include only the specified AUs in the corr).
%            Example of usage:
%            colNames = {'AU_25', 'AU_26', 'AU_18i', 'AU_16', 'lowerNone', 'AU_1_2', 'AU_43_5', 'upperNone'};
%            setupSumAUsCorrMats(catTblsPath, allSubjAuSumDir, isShow, isSubjectsSum, colNames)

if nargin < 4   % isSubjectsSum
    isSubjectsSum = false;
end


subjAUsInFramesTbl =  sumAUsInFramesTbls(AUsFramesTblsFileCol, isSubjectsSum);

if nargin < 5   % colNames
    colNames = subjAUsInFramesTbl.Properties.VariableNames(2:end);
end

[subjAUsCorrMat, fig] = createAUsCorrMat(subjAUsInFramesTbl, colNames, isShow, '', colNames);

if ~exist(subjAuSumDir, 'dir')
    mkdir(subjAuSumDir);
end

if nargin < 5   % colNames
    save(fullfile(subjAuSumDir, 'subjAUsInFramesTbl.mat'), 'subjAUsInFramesTbl');
    save(fullfile(subjAuSumDir, 'subjAUsCorrMat.mat'), 'subjAUsCorrMat');

    if isShow
        saveas(fig, fullfile(subjAuSumDir, 'subjAUsCorrMat.fig'));
    end
else
    save(fullfile(subjAuSumDir, 'subjAUsInFramesTbl_relCols.mat'), 'subjAUsInFramesTbl');
    save(fullfile(subjAuSumDir, 'subjAUsCorrMat_relCols.mat'), 'subjAUsCorrMat');

    if isShow
        saveas(fig, fullfile(subjAuSumDir, 'subjAUsCorrMat_relCols.fig'));
    end
end

