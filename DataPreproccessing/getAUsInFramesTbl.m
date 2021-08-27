function AUsInFramesTbl = getAUsInFramesTbl(framesNums, AUs_summary_tbl)

AUsInFramesTbl = [];
if isempty(AUs_summary_tbl)
    return;
end
    
varNames = {'frameNum', AUs_summary_tbl.Properties.VariableNames{:}};

nRows = length(framesNums);
nCols = length(varNames);
AUsInFramesTbl  = array2table(zeros(nRows, nCols), 'VariableNames', varNames);

AUsInFramesTbl.frameNum = framesNums;

for i=1:width(AUs_summary_tbl)
    thisColFramesNums = AUs_summary_tbl{{'VidTimes'},i}{:};
    locFrames = ismember(AUsInFramesTbl.frameNum, thisColFramesNums);
    
    % i+1 because the first column of AUsInFramesTbl is frameNum 
    AUsInFramesTbl{locFrames, i+1} = 1;
end