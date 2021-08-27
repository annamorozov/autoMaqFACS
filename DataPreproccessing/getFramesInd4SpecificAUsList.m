function framesInd = getFramesInd4SpecificAUsList(AUsInFramesTbl, AU_colNamesList, isExclusive)
% Get frame indices for a list of specific AUs 

% isExclusive - optional param. True by default. When true, the
% function returns indices only of frames containing exclusively AUs
% specified in [AU_colNamesList]. If false, the frames may co-occure with other AUs. 

framesInd  = [];
logicalFramesRes = true(height(AUsInFramesTbl), 1);
logicalAUsCols   = false(1, width(AUsInFramesTbl));

if nargin < 3   % isExclusive
    isExclusive = true;
end

for i = 1:length(AU_colNamesList)

    AU_colName = AU_colNamesList{i};
    
    [~, logicalFrameInd, logicalColInd] = getFramesInd4SpecificAU(AUsInFramesTbl, AU_colName);
    if isempty(logicalFrameInd)
        fprintf('The column %s does not exist in the table\n', AU_colName);
        return;
    end
    
    % AND btw the columns of the requested AUs
    logicalFramesRes = logicalFramesRes & logicalFrameInd;
    
    logicalAUsCols = logicalAUsCols | logicalColInd;
end
 
if isExclusive
    % Only the requested AUs and not others
    logicalOtherAUsCols = ~logicalAUsCols;
    logicalOtherAUsCols(1) = false; % 1st column in AUsInFramesTbl is frameNum

    otherAUsColInd = find(logicalOtherAUsCols == 1);
    for i = 1:length(otherAUsColInd)
        logicalFramesRes = logicalFramesRes & ~(AUsInFramesTbl{:, otherAUsColInd(i)});
    end
end

framesInd = AUsInFramesTbl.frameNum(logicalFramesRes);





