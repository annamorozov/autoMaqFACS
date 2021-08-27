function localInd = globalVidInd2Local(globalInd, training_matchedTimes_tbl)
% Convert global frame index of a video (as in the original video) 
% to a local one (where frames that are not for analysis removed) 

firstFrame = training_matchedTimes_tbl.Frame_n(1);

localInd = globalInd - firstFrame + 1;