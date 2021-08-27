function [framesInd, logicalFrameInd, logicalColInd] = getFramesInd4SpecificAU(AUsInFramesTbl, AU_colName)
% Get the indices of specific AU frames

    framesInd  = [];
    logicalFrameInd = [];

    % Returns logical vector for each table column
    isTableCol_logical = @(t, thisCol) ismember(t.Properties.VariableNames, thisCol);

    logicalColInd = isTableCol_logical(AUsInFramesTbl, AU_colName);
    if ~any(logicalColInd)
        fprintf('The column %s does not exist in the table\n', AU_colName);
        return
    end
    
    thisCol = AUsInFramesTbl{:,{AU_colName}};
    thisColInd = find(thisCol);
    framesInd = AUsInFramesTbl.frameNum(thisColInd);
    
    logicalFrameInd = logical(thisCol);
end

