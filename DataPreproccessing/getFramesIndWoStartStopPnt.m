function framesInd = getFramesIndWoStartStopPnt(AU_matchedTimes_tbl)
% Get frame indices without AU point events and the AU start and stop frames

rowsInd2exclude = [];

rowsInd2exclude = strcmp(AU_matchedTimes_tbl.Event_Type,'State start');
rowsInd2exclude = rowsInd2exclude | strcmp(AU_matchedTimes_tbl.Event_Type,'State stop');
rowsInd2exclude = rowsInd2exclude | strcmp(AU_matchedTimes_tbl.Event_Type,'Point');

framesInd = AU_matchedTimes_tbl.Frame_n(~rowsInd2exclude);
