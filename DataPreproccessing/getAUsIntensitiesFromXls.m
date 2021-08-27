function intensitiesTbl = getAUsIntensitiesFromXls(xlsFilename, removedRows)
% Get the intensities from Observer output xls files

raw = readtable(xlsFilename);

[~, relevInds] = excludeNotForAnalysisRows(raw);

if ~strcmp('Modifier_1',raw.Properties.VariableNames)
    intensitiesTbl = [];
    return;
end

relevColsTbl = table(raw.Modifier_1, 'VariableNames', {'Modifier_1'});
relevColsTbl = relevColsTbl(relevInds, :);

if ~isempty(removedRows)
    intensitiesTbl = relevColsTbl(~removedRows,:);
else
    intensitiesTbl = relevColsTbl;
end