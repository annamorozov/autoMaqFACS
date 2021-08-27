function sumTbl = catSubjAuFreqTbls(freqTblsPathList, bAddRowSubjName)
% Concatenate subjects' AU frequency tables

sumTbl = [];

for i = 1:length(freqTblsPathList)
    load(fullfile(freqTblsPathList{i}, 'subjAuFreqTbl.mat'), 'subjAuFreqTbl');
    
    if bAddRowSubjName
        [dirName, ~, ~] = fileparts(freqTblsPathList{i});
        [~, subjName, ~] = fileparts(dirName);
        subjAuFreqTbl.Properties.RowNames = {subjName};
    end
    
    if i == 1
        sumTbl = subjAuFreqTbl;
        continue;
    else
        sumTbl = cat2tbls(sumTbl, subjAuFreqTbl);
    end
end