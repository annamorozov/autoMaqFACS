function sumFreqTbl = sumSubjAUsFreqTbls(subjAuSumDirCol)

% The function creates a summary table of AUs frequencies 
% for all the subjects.

sumFreqTbl = [];

for i = 1:length(subjAuSumDirCol)
    load(fullfile(subjAuSumDirCol{i}, 'subjAuFreqTbl.mat'), 'subjAuFreqTbl');
   
    if i == 1        
        sumFreqTbl = subjAuFreqTbl;
        continue;
    else
        % Handle the tables in pairs, in an incremental way
        sumFreqTbl = sum2FreqTblsOfAUs(sumFreqTbl, subjAuFreqTbl);
    end
end

