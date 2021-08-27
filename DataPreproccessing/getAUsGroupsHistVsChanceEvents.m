function histHandle = getAUsGroupsHistVsChanceEvents(AuGroupsFreqTbl, titleStr)

% The function creates histogram of AUs groups frequencies vs chance level
% events

% Create the histogram of the real events
nonZeroFreqInd = AuGroupsFreqTbl.groupsFreq > 0;

figure;
histHandle = histogram('Categories',AuGroupsFreqTbl.AUs_title(nonZeroFreqInd),...
    'BinCounts',AuGroupsFreqTbl.groupsFreq(nonZeroFreqInd), 'DisplayOrder','descend');
hold on;

% Get the order of the categories as displayed in the histogram
orderedCats = histHandle.Categories;

rowsOrder = [];
for i = 1:length(orderedCats)
    r = find(strcmp(orderedCats{i}, AuGroupsFreqTbl.AUs_title));
    rowsOrder = [rowsOrder r];
end

% Plot the chance level events
eventsNum = AuGroupsFreqTbl.nAUsGroupEvents(rowsOrder);
orderedCategorical = categorical(orderedCats);

plot(orderedCategorical, eventsNum, 'r*', 'MarkerSize', 10);

if nargin == 2  % titleStr
    title(titleStr, 'Interpreter', 'none');    % Handle '_' char as is
end




