function fullSetupPrepareTrainingData_LowerFace(procDataDir_allSubj, subjNames, sectionsToSkip)

dbRDir_DeltaOneFr_ColName        = 'lowerFaceDBRDir_DeltaOneFr';
AUsImgTables_AllSubjDirName      = 'AUsImgTables_LowerFace_DeltaOneFr';
AUsFramesTblsFileColName         = 'lowerFaceAUsFramesTblsFile';

allSubjDirName = strjoin(subjNames,'_');   
allSubjMetaDir = fullfile(procDataDir_allSubj, allSubjDirName);

AUsImgTables_LowerFace_AllSubjDir = fullfile(allSubjMetaDir, AUsImgTables_AllSubjDirName);

if nargin < 3   % sectionsToSkip
    sectionsToSkip = [];
end

%% Prepare table of AUs 25 and 26 specific images (from DB) for lower face ROI

if ~ismember(1, sectionsToSkip)
    AUs_2_classify = {'AU_25', 'AU_26'};
    tblRowsNum = 15000;

    generateAUsGroup_FramesTblFromDB_allSubj(AUs_2_classify, subjNames, procDataDir_allSubj,...
        AUsFramesTblsFileColName, dbRDir_DeltaOneFr_ColName,...
        allSubjMetaDir, AUsImgTables_AllSubjDirName, tblRowsNum);
end

%% Prepare table of AUs 25, 26 and 16 specific images (from DB) for lower face ROI
if ~ismember(2, sectionsToSkip)
    AUs_2_classify = {'AU_25', 'AU_26', 'AU_16'};

    generateAUsGroup_FramesTblFromDB_allSubj(AUs_2_classify, subjNames, procDataDir_allSubj,...
        AUsFramesTblsFileColName, dbRDir_DeltaOneFr_ColName,...
        allSubjMetaDir, AUsImgTables_AllSubjDirName);
end

%% Prepare table of AUs 25, 26 and 18i specific images (from DB) for lower face ROI
if ~ismember(3, sectionsToSkip)
    AUs_2_classify = {'AU_25', 'AU_26', 'AU_18i'};

    generateAUsGroup_FramesTblFromDB_allSubj(AUs_2_classify, subjNames, procDataDir_allSubj,...
        AUsFramesTblsFileColName, dbRDir_DeltaOneFr_ColName,...
        allSubjMetaDir, AUsImgTables_AllSubjDirName);
end


