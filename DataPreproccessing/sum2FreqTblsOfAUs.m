function sumTbl = sum2FreqTblsOfAUs(t1, t2)
% Summarize 2 frequency tables of AUs

t1colmissing = setdiff(t2.Properties.VariableNames, t1.Properties.VariableNames);
t2colmissing = setdiff(t1.Properties.VariableNames, t2.Properties.VariableNames);

t1 = [t1 array2table(zeros(height(t1), numel(t1colmissing)), 'VariableNames', t1colmissing)];
t2 = [t2 array2table(zeros(height(t2), numel(t2colmissing)), 'VariableNames', t2colmissing)];

t1.Properties.RowNames = {'1'}; % To overcome the issue of same name rows

t = [t1; t2];

% Sanity check
if height(t) ~= 2
    error('The number of rows in the cat table should be exacly 2!');
end

sumRow = cell2mat(t{1,:}) + cell2mat(t{2,:});

sumTbl  = cell2table(cell(1, length(sumRow)), 'VariableNames', t.Properties.VariableNames);
sumTbl{1,:} = num2cell(sumRow);