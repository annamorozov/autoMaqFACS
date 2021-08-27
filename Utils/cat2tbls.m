function sumTbl = cat2tbls(t1, t2, isIgnoreNonscalar)
% Concatenate 2 tables

% isIgnoreNonscalar - optional param

if nargin < 3   % isIgnoreNonscalar
    isIgnoreNonscalar = false;
end

t1colmissing = setdiff(t2.Properties.VariableNames, t1.Properties.VariableNames);
t2colmissing = setdiff(t1.Properties.VariableNames, t2.Properties.VariableNames);

t1 = [t1 cell2table(cell(height(t1), numel(t1colmissing)), 'VariableNames', t1colmissing)];
t2 = [t2 cell2table(cell(height(t2), numel(t2colmissing)), 'VariableNames', t2colmissing)];

sumTbl = [t1; t2];

if ~isIgnoreNonscalar
    % Get rid of non-scalar values (to enable sorting)
    sumCellArr = sumTbl{:,:};
    nonScalarInd = ~cellfun(@isscalar,sumCellArr);
    sumCellArr(nonScalarInd) = {0};
    sumTbl = array2table(sumCellArr, 'VariableNames', sumTbl.Properties.VariableNames, 'RowNames', sumTbl.Properties.RowNames);
end