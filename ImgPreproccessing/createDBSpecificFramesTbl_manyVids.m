function specificFramesTbl_fromDBs = createDBSpecificFramesTbl_manyVids(folderFullNameList, framesIndList)

% Output as in createDBSpecificFramesTbl but from many videos.

% Outputs a table with the following columns:
% 'dbDir', 'frameInd', 'imgCell'
% imgCell - contains the img in a cell

if length(folderFullNameList) ~= length(framesIndList)
    error('The lengths of DB dir list and frames indices list are not equal!\n');
end 

specificFramesTbl_fromDBs = [];

for i=1:length(folderFullNameList)
    thisTbl = createDBSpecificFramesTbl(folderFullNameList{i}, framesIndList{i});
    specificFramesTbl_fromDBs = [specificFramesTbl_fromDBs; thisTbl];
end
