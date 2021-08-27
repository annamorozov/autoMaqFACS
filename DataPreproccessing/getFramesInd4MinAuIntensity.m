function framesInd = getFramesInd4MinAuIntensity(minIntensityChar,...
    AU_matchedTimes_tbl)

% minIntensityChar: 'a' or 'b' or 'c' or 'd' or 'e'

ind = double(char(AU_matchedTimes_tbl.AU_intensities)) >= double(minIntensityChar);

framesInd = AU_matchedTimes_tbl.Frame_n(ind);