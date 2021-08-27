function sumAUsTbl = sum2AUsInFramesTbls(sumAUsInFramesTbl, AUsInFramesTbl_2add)

% The function unites 2 tables of AUs in frames

% find the missing columns in both tables
sumTbl_missingCols = setdiff(AUsInFramesTbl_2add.Properties.VariableNames,...
    sumAUsInFramesTbl.Properties.VariableNames);

tbl2Add_missingCols = setdiff(sumAUsInFramesTbl.Properties.VariableNames,...
    AUsInFramesTbl_2add.Properties.VariableNames);

% add the missing columns to the tables and fill them with zeroes
sumAUsInFramesTbl = [sumAUsInFramesTbl array2table(zeros(height(sumAUsInFramesTbl), numel(sumTbl_missingCols)),...
    'VariableNames', sumTbl_missingCols)];
AUsInFramesTbl_2add = [AUsInFramesTbl_2add array2table(zeros(height(AUsInFramesTbl_2add), numel(tbl2Add_missingCols)),...
    'VariableNames', tbl2Add_missingCols)];

sumAUsTbl = [sumAUsInFramesTbl; AUsInFramesTbl_2add];