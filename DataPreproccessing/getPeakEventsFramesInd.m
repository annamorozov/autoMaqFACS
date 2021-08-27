function framesInd = getPeakEventsFramesInd(AU_matchedTimes_tbl)
% Get frame indices of AU peak events

lInd = logical(AU_matchedTimes_tbl.isPointEvent);
framesInd = AU_matchedTimes_tbl.Frame_n(lInd);