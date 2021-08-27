function histHandle = getAUsGroupsHistogram(AuGroupsFreqTbl, titleStr)

% The function creates histogram of AUs groups frequencies

nonZeroFreqInd = AuGroupsFreqTbl.groupsFreq > 0;
if ~any(nonZeroFreqInd)
    histHandle = [];
    return;
end

figure;
histHandle = histogram('Categories', AuGroupsFreqTbl.AUs_title(nonZeroFreqInd), 'BinCounts'...
    ,AuGroupsFreqTbl.groupsFreq(nonZeroFreqInd), 'DisplayOrder','descend');

if nargin == 2  % titleStr
    title(titleStr, 'Interpreter', 'none');    % Handle '_' char as is
end



