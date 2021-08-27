function sumFreqTbl = sumAUsGroupsFreqTbls(AuGroupsFreqTblDirCol, groupSize, isSubjectsSum)

% The function creates a summary table of AUs groups frequencies 
% for all the training videos of the subject.

% isSubjectsSum - optional param

if nargin < 3   % isSubjectsSum
    isSubjectsSum = false;
end

sumFreqTbl  = cell2table(cell(0,3), 'VariableNames', {'AU_names', 'AUs_title', 'groupsFreq'});

for i = 1:length(AuGroupsFreqTblDirCol)
    fileName = sprintf('AuGroupsFreqTbl_%d.mat', groupSize);
    if isSubjectsSum
        fileName = sprintf('subjAuGroupsFreqTbl_%d.mat', groupSize);
    end
    
    fullFilename = fullfile(AuGroupsFreqTblDirCol{i}, fileName);
    
    if exist(fullFilename, 'file') ~= 2
        continue;
    end
    
    varName = 'AuGroupsFreqTbl';
    if isSubjectsSum
        varName = 'subjAuGroupsFreqTbl';
    end
    
    AuGroupsFreqTbl = loadAndRenameVar(fullFilename, varName);
    %load(fullFilename, varName);
        
    if i == 1
        nonZeroFreqInd = AuGroupsFreqTbl.groupsFreq > 0;
        freqTbl = AuGroupsFreqTbl(nonZeroFreqInd, :);
        
        if ~isSubjectsSum
            freqTbl(:,'AU_sumTblInd') = [];
        end

        sumFreqTbl = [sumFreqTbl; freqTbl];
        continue;
    end
    
    % Handle the tables in pairs, in an incremental way
    sumFreqTbl = sum2AUsGroupsFreqTbls(sumFreqTbl, AuGroupsFreqTbl, groupSize);
end

