function [AUs_freq_tbl, AUs_parsed_full_list] = getAUsFreqTbl(cleanXlsTbl)
% AUs frequencies in the input table. Doesn't consider duration! Only parses AUs
% and returns their count in the table.

raw = cleanXlsTbl;

% pattern to extract the AU names
pattern = '(EAU)\d|\d+(i+)|\d+\+\d+|\d+_\d+|\d+|(EAD)';

% AU names are in the "Behavior" column
cell_arr = regexp(raw.Behavior(:), pattern, 'match');
list = [cell_arr{:}];
AUs_parsed_full_list = list';

% If list is a vector, then C = list(ia) and list = C(ic).
[C,~,ic]=unique(list);

% make table of frequencies for AU indices
tbl = tabulate(ic);
% sort according to frequencies (2nd column)
[tbl_sort, ~] = sortrows(tbl,-2);

AU_freq_cell = num2cell(tbl_sort);
% add AU names in the last (4th) column for readability
AU_freq_cell(:,4) = C(tbl_sort(:,1));       % This is the frequncies summary table

AUs_freq_tbl = cell2table(AU_freq_cell, 'VariableNames',{'AU_Indx', 'Count', 'Percent', 'AU_Name'});

