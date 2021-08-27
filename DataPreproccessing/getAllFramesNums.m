function framesNums = getAllFramesNums(AUs_summary_tbl)

% Getting all labeled frames nums

framesNums = [];

for i=1:width(AUs_summary_tbl)
    thisColFramesNums = AUs_summary_tbl{{'VidTimes'},i}{:};
    framesNums = [framesNums; thisColFramesNums];
    end

framesNums = unique(framesNums);