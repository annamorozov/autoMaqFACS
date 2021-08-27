function generateAUsGroup_FramesTblFromDB_allSubj(AUs_2_classify, subjNames, procDataDir_allSubj,...
    AUsFramesTblsFileColName, DBRunDirColName,...
    allSubjMetaDir, AUsImgTables_AllSubjDirName,...
    tblRowsNum, isExclusive)

% Generate frames table of AU group, for all subjects

% tblRowsNum - optional param. If the table is too big to save,
% [tblRowsNum] rows may be extracted from the initial table

% isExclusive - optional param. True by default. When true, the
% function returns indices only of frames containing exclusively AUs
% specified in [AU_colNamesList]. If false, the frames may co-occure with other AUs. 

%% Prepare table of AUs group specific images (from DB)

AUs_FramesTbl_fromDBs_allSubj  = [];

if nargin < 9   % isExclusive
    isExclusive = true;
end

for i = 1:length(subjNames)
    [pathTbl, ~] = loadPathTbls(procDataDir_allSubj, subjNames{i});
    
    AUs_FramesTbl_fromDBs = prepareGroupAUsImgTbl_manyVids(pathTbl.(AUsFramesTblsFileColName),...
        pathTbl.(DBRunDirColName), AUs_2_classify, pathTbl.AUsFramesTblsFile, isExclusive);
    
    AUs_FramesTbl_fromDBs_allSubj = [AUs_FramesTbl_fromDBs_allSubj;...
        AUs_FramesTbl_fromDBs];
end

AUs_FramesTbl_fromDBs_allSubj = addSubjTrialCols2FramesTbl(AUs_FramesTbl_fromDBs_allSubj);

if nargin > 7 && tblRowsNum ~= 0   % tblRowsNum
    % Make the frames tables smaller
    if height(AUs_FramesTbl_fromDBs_allSubj) > tblRowsNum
        AUs_FramesTbl_fromDBs_allSubj = getNRowsFromTbl(AUs_FramesTbl_fromDBs_allSubj, tblRowsNum);

        if ~height(AUs_FramesTbl_fromDBs_allSubj)
            error('AUs_FramesTbl_fromDBs_allSubj returned with 0 rows');
        end
    end
end

% Save the tables
AUsImgTables_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);

if ~exist(AUsImgTables_AllSubjDir, 'dir')
  mkdir(AUsImgTables_AllSubjDir);
end

prefix = strjoin(AUs_2_classify, '_');
fileName = sprintf('%s_FramesTbl_fromDBs_allSubj', prefix);
fileName = sprintf('%s.mat', fileName);

save(fullfile(AUsImgTables_AllSubjDir, fileName),  'AUs_FramesTbl_fromDBs_allSubj', '-v7.3');