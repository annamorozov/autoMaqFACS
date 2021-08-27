function exper_fullSetupPrepareTestData_UpperFace(procDataDir_allSubj, subjNames)
% Prepare the data for validation and testing

% TODO: most of this is a duplicate of
% fullSetupPrepareTrainingData_UpperFace, needs to be refactored.

dbRDir_DeltaOneFr_ColName        = 'upperFaceDBRDir_DeltaOneFr';
AUsImgTables_AllSubjDirName      = 'AUsImgTables_UpperFace_DeltaOneFr';

allSubjDirName = strjoin(subjNames,'_');  
allSubjMetaDir = fullfile(procDataDir_allSubj, allSubjDirName);


%% Prepare table of 'absolute' neutral images (from DB) for upper face ROI
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

save(fullfile(AUsImgTables_UpperFace_AllSubjDir,'neutralAbs_FramesTbl_fromDBs_allSubj.mat'),...
     'neutralAbs_FramesTbl_fromDBs_allSubj', '-v7.3');
 
%% Prepare table of AU 43_5 specific images (from DB) for upper face ROI

AU_2_classify = 'AU_43_5';
AU_43_5_FramesTbl_fromDBs_allSubj  = [];

for i = 1:length(subjNames)
    [pathTbl, ~] = loadPathTbls(procDataDir_allSubj, subjNames{i});
    
    AU_43_5_FramesTbl_fromDBs = prepareSingleAUImgTbl_manyVids(pathTbl.AUsFramesTblsFile,...
        pathTbl.(dbRDir_DeltaOneFr_ColName), AU_2_classify);
    
    AU_43_5_FramesTbl_fromDBs_allSubj = [AU_43_5_FramesTbl_fromDBs_allSubj;...
        AU_43_5_FramesTbl_fromDBs];
end

AU_43_5_FramesTbl_fromDBs_allSubj.label(:) = {'AU_43'};
AU_43_5_FramesTbl_fromDBs_allSubj          = addSubjTrialCols2FramesTbl(AU_43_5_FramesTbl_fromDBs_allSubj);

% Save the tables
AUsImgTables_UpperFace_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);

if ~exist(AUsImgTables_UpperFace_AllSubjDir, 'dir')
  mkdir(AUsImgTables_UpperFace_AllSubjDir);
end

save(fullfile(AUsImgTables_UpperFace_AllSubjDir,'AU_43_5_FramesTbl_fromDBs_allSubj.mat'),  'AU_43_5_FramesTbl_fromDBs_allSubj');
        

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

save(fullfile(AUsImgTables_UpperFace_AllSubjDir,'AU_1_2_FramesTbl_fromDBs_allSubj.mat'),  'AU_1_2_FramesTbl_fromDBs_allSubj', '-v7.3');


