function [cleanTbl, removedRows] = cleanAUsXls(xlsFilename)
% Clean the Observer xls output files with AU labels

raw = readtable(xlsFilename);

%% Exclude all the rows "not for analysis" from the beginning and form the end

[relevRowsTbl, ~] = excludeNotForAnalysisRows(raw);

%% Remove rows with missing values

missingIndicators = {'','unknown','not for analysis'};
dataVar = {'Behavior'};

standardTbl = standardizeMissing(relevRowsTbl, missingIndicators, 'DataVariables', dataVar);
[cleanTbl,removedRows] = rmmissing(standardTbl, 'DataVariables', dataVar);

% sanity check
missingAURows = ismissing(relevRowsTbl.Behavior, missingIndicators);

if removedRows ~= missingAURows
    error('Cleaning of %s table is inconsistent!\n', xlsFilename);
    return;
end