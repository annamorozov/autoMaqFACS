function fullSetupPrepareTrainingDBs_LowerFace(procDataDir_allSubj, subjNames, sectionsToSkip)

% Params
trainingVidFileColName           = 'lowerFaceTrainingVidFile';
trainingDeltaOneFrVidFileColName = 'lowerFaceTrainingDeltaOneFrVidFile';
dbRDir_DeltaOneFr_ColName        = 'lowerFaceDBRDir_DeltaOneFr';


if nargin < 3   % sectionsToSkip
    sectionsToSkip = [];
end


%% Choose best neutral frames (one per vid)

if ~ismember(1, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupChooseBestNeutralFrames(pathTbl);
    end
end

%% Prepare the delta videos (vs. one best neutral frame) for lower face ROI

if ~ismember(2, sectionsToSkip)
    isVsOneNeutrFrame = true;
    
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupPrepareDeltaVid(pathTbl.(trainingVidFileColName), pathTbl.(trainingDeltaOneFrVidFileColName),...
            pathTbl.lowerFaceDir, pathTbl.AUsFramesTblsFile, isVsOneNeutrFrame);
    end
end

%% Convert the delta videos (vs. one best neutral frame) of lower face ROI to DB
if ~ismember(3, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupConvertVid2DB(pathTbl.(trainingDeltaOneFrVidFileColName), pathTbl.(dbRDir_DeltaOneFr_ColName));
    end
end