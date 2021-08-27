function histHandle = getAUsFreqHistogram(AuNamesList, AuFreqList, titleStr)

% The function creates histogram of AUs frequencies

figure;
histHandle = histogram('Categories', AuNamesList, 'BinCounts', cell2mat(AuFreqList),...
    'DisplayOrder','descend');

set(gca,'TickLabelInterpreter','none');

if nargin > 2 && ~isempty(titleStr)  % titleStr
    title(titleStr, 'Interpreter', 'none');    % Handle '_' char as is
end