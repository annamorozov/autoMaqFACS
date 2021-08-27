function groupAUs_FramesTbl_fromDBs = ...
    prepareGroupAUsImgTbl_manyVids(AUsFramesTblsFileCol, DBRunDirCol, AU_colNamesList,...
    trainingMatchedTimesTblsFileCol, isExclusive)
% Create frames table with frames of AU groups, from many videos

% isExclusive - optional param. True by default. When true, the
% function returns indices only of frames containing exclusively AUs
% specified in [AU_colNamesList]. If false, the frames may co-occure with other AUs. 

if length(AUsFramesTblsFileCol) ~= length(DBRunDirCol)
    error('Different length of AUs frames tables column and DB run dir column!');
end

groupAUs_FramesTbl_fromDBs = [];

len = length(AUsFramesTblsFileCol);
localFramesInd_AU_allVids  = cell(len,1);

if nargin < 5   % isExclusive
    isExclusive = true;
end


for i=1:len
    load(AUsFramesTblsFileCol{i}, 'AUsInFramesTbl');
    load(trainingMatchedTimesTblsFileCol{i}, 'training_matchedTimes_tbl');

    globalFramesInd_AU = getFramesInd4SpecificAUsList(AUsInFramesTbl, AU_colNamesList, isExclusive);

    if ~isempty(globalFramesInd_AU)
        localFramesInd_AU  = globalVidInd2Local(globalFramesInd_AU, training_matchedTimes_tbl);
    else
        localFramesInd_AU = [];
    end
    
    localFramesInd_AU_allVids{i} = localFramesInd_AU;
end

label = strjoin(AU_colNamesList,'_');   % 'AU_25_AU_26'

vidInd = find(~cellfun(@isempty,localFramesInd_AU_allVids));
if any(vidInd)
    groupAUs_FramesTbl_fromDBs  = createDBSpecificFramesTbl_manyVids(DBRunDirCol(vidInd), localFramesInd_AU_allVids(vidInd));

    %Add labels column:
    [lblCol_AU{1:height(groupAUs_FramesTbl_fromDBs)}] = deal(label);

    groupAUs_FramesTbl_fromDBs = [groupAUs_FramesTbl_fromDBs,...
        array2table(lblCol_AU', 'VariableNames',{'label'})];
end




