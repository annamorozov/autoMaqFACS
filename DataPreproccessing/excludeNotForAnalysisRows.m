function [relevRowsTbl, relevInds] = excludeNotForAnalysisRows(rawFromXls)

relevRowsTbl = [];
relevInds = [];

relevColsTbl = table(rawFromXls.Time_Relative_sf, rawFromXls.Duration_sf, rawFromXls.Behavior, rawFromXls.Event_Type,...
    'VariableNames', {'Time_Relative_sf', 'Duration_sf', 'Behavior', 'Event_Type'});

%% Exclude all the rows "not for analysis" from the beginning and from the end

notForAnalysInd = find(strcmp('not for analysis', rawFromXls.Behavior));

if ~isempty(notForAnalysInd)
    % The relevant rows are the rows between 2 'not for analysis' rows with the
    % biggest interval
    notForAnalysIndDiff = diff(notForAnalysInd);
    [~,maxInd] = max(notForAnalysIndDiff);

    startInd = notForAnalysInd(maxInd)+1;
    endInd = notForAnalysInd(maxInd+1)-1;

    relevRowsTbl = relevColsTbl(startInd:endInd,:);
    relevInds = startInd:endInd;
else
    relevRowsTbl = relevColsTbl;
    relevInds = 1:height(relevRowsTbl);
end