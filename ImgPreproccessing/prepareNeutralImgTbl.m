function neutralAbs_FramesTbl_fromDBs =...
    prepareNeutralImgTbl(AUsFramesTblsFileCol, DBRunDirCol)

% Prepare a table of neutral frames from DBs

if length(AUsFramesTblsFileCol) ~= length(DBRunDirCol)
    error('Different length of AUs frames tables column and DB run dir column!');
end

len = length(AUsFramesTblsFileCol);

localFramesInd_abs_neutral_allVids   = cell(len,1);

for i=1:len
    load(AUsFramesTblsFileCol{i}, 'neutralFramesInd');
    
    localFramesInd_abs_neutral_allVids{i}   = neutralFramesInd.neutralFrames_Abs_TrainingVidIndx';
end

neutralAbs_FramesTbl_fromDBs   = createDBSpecificFramesTbl_manyVids(DBRunDirCol, localFramesInd_abs_neutral_allVids);

%Add labels column:
[lblCol_neutrAbs{1:height(neutralAbs_FramesTbl_fromDBs)}]       = deal('neutral_abs');

neutralAbs_FramesTbl_fromDBs = [neutralAbs_FramesTbl_fromDBs,...
    array2table(lblCol_neutrAbs', 'VariableNames',{'label'})];


