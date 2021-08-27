function fullSetupPrepareTrainingData_UpperFace(procDataDir_allSubj, subjNames)
% Prepare the data for training

dbRDir_DeltaOneFr_ColName        = 'upperFaceDBRDir_DeltaOneFr';
AUsImgTables_AllSubjDirName      = 'AUsImgTables_UpperFace_DeltaOneFr';

allSubjDirName = strjoin(subjNames,'_');  
allSubjMetaDir = fullfile(procDataDir_allSubj, allSubjDirName);

AUsImgTables_UpperFace_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);


%% Prepare table of neutral images (from DB) for upper face ROI
neutralAbs_FramesTbl_fromDBs_allSubj    = [];

for i = 1:length(subjNames)
    [pathTbl, ~] = loadPathTbls(procDataDir_allSubj, subjNames{i});
    
    neutralAbs_FramesTbl_fromDBs =...
        prepareNeutralImgTbl(pathTbl.AUsFramesTblsFile, pathTbl.(dbRDir_DeltaOneFr_ColName));
    
    neutralAbs_FramesTbl_fromDBs_allSubj = [neutralAbs_FramesTbl_fromDBs_allSubj;...
        neutralAbs_FramesTbl_fromDBs];    
end

neutralAbs_FramesTbl_fromDBs_allSubj = addSubjTrialCols2FramesTbl(neutralAbs_FramesTbl_fromDBs_allSubj);

% Save the tables
AUsImgTables_UpperFace_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);

if ~exist(AUsImgTables_UpperFace_AllSubjDir, 'dir')
  mkdir(AUsImgTables_UpperFace_AllSubjDir);
end

fileName = 'neutralAbs_FramesTbl_fromDBs_allSubj';
save(fullfile(AUsImgTables_UpperFace_AllSubjDir, fileName),  'neutralAbs_FramesTbl_fromDBs_allSubj', '-v7.3');

% Make the neutral frames tables smaller, in the magnitude of the training AUs
% tables
rowsNum = 10000;

neutralAbs_FramesTbl_fromDBs_allSubj_med = getNRowsFromTbl(neutralAbs_FramesTbl_fromDBs_allSubj, rowsNum);
if ~height(neutralAbs_FramesTbl_fromDBs_allSubj_med)
    error('neutralAbs_FramesTbl_fromDBs_allSubj_med returned with 0 rows');
end

fileName = 'neutralAbs_FramesTbl_fromDBs_allSubj_med';
fileName = sprintf('%s.mat', fileName);

save(fullfile(AUsImgTables_UpperFace_AllSubjDir, fileName),...
    'neutralAbs_FramesTbl_fromDBs_allSubj_med', '-v7.3');

clear neutralAbs_FramesTbl_fromDBs_allSubj_med;
clear neutralAbs_FramesTbl_fromDBs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prepare table of AU 43 specific images (from DB) for upper face ROI

AU_2_classify = 'AU_43';
AU_43_FramesTbl_fromDBs_allSubj  = [];

for i = 1:length(subjNames)
    [pathTbl, ~] = loadPathTbls(procDataDir_allSubj, subjNames{i});
    
    AU_43_FramesTbl_fromDBs = prepareSingleAUImgTbl_manyVids(pathTbl.AUsFramesTblsFile,...
        pathTbl.(dbRDir_DeltaOneFr_ColName), AU_2_classify);
    
    AU_43_FramesTbl_fromDBs_allSubj = [AU_43_FramesTbl_fromDBs_allSubj;...
        AU_43_FramesTbl_fromDBs];
end

AU_43_FramesTbl_fromDBs_allSubj = addSubjTrialCols2FramesTbl(AU_43_FramesTbl_fromDBs_allSubj);

% Save the tables
AUsImgTables_UpperFace_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);

if ~exist(AUsImgTables_UpperFace_AllSubjDir, 'dir')
  mkdir(AUsImgTables_UpperFace_AllSubjDir);
end

fileName = 'AU_43_FramesTbl_fromDBs_allSubj';
fileName = sprintf('%s.mat', fileName);

save(fullfile(AUsImgTables_UpperFace_AllSubjDir, fileName),  'AU_43_FramesTbl_fromDBs_allSubj', '-v7.3');

clear AU_43_FramesTbl_fromDBs_allSubj;
clear AU_43_FramesTbl_fromDBs;

      
%% Prepare table of AU 1+2 specific images (from DB) for upper face ROI

AU_2_classify = 'AU_1_2';
AU_1_2_FramesTbl_fromDBs_allSubj  = [];


for i = 1:length(subjNames)
    [pathTbl, ~] = loadPathTbls(procDataDir_allSubj, subjNames{i});
    
    AU_1_2_FramesTbl_fromDBs = prepareSingleAUImgTbl_manyVids(pathTbl.AUsFramesTblsFile,...
        pathTbl.(dbRDir_DeltaOneFr_ColName), AU_2_classify);
    
    AU_1_2_FramesTbl_fromDBs_allSubj = [AU_1_2_FramesTbl_fromDBs_allSubj;...
        AU_1_2_FramesTbl_fromDBs];
end

AU_1_2_FramesTbl_fromDBs_allSubj = addSubjTrialCols2FramesTbl(AU_1_2_FramesTbl_fromDBs_allSubj);

% Save the tables
AUsImgTables_UpperFace_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);

if ~exist(AUsImgTables_UpperFace_AllSubjDir, 'dir')
  mkdir(AUsImgTables_UpperFace_AllSubjDir);
end

fileName = 'AU_1_2_FramesTbl_fromDBs_allSubj';
fileName = sprintf('%s.mat', fileName);

save(fullfile(AUsImgTables_UpperFace_AllSubjDir, fileName),  'AU_1_2_FramesTbl_fromDBs_allSubj');

clear AU_1_2_FramesTbl_fromDBs_allSubj;
clear AU_1_2_FramesTbl_fromDBs;



