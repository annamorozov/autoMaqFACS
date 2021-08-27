function fullSetupPrepareTrainingDBs_UpperFace(procDataDir_allSubj, subjNames, copySourceProcDataDir_allSubj, isNeutrROI, sectionsToSkip)

% isNeutrROI - optional param: take the neutral frame as neutral for specific
%              ROI (upper in this case) and not absolutely neutral. 
%              'false' - default (absolute), 'true' - upper face neutral

% Params
trainingVidFileColName           = 'upperFaceTrainingVidFile';
trainingDeltaOneFrVidFileColName = 'upperFaceTrainingDeltaOneFrVidFile';
dbRDir_DeltaOneFr_ColName        = 'upperFaceDBRDir_DeltaOneFr';

if nargin < 3   % copySourceProcDataDir_allSubj
    copySourceProcDataDir_allSubj = '';
end

if nargin < 4   % isNeutrROI
    isNeutrROI = false;
end

if nargin < 5   % sectionsToSkip
    sectionsToSkip = [];
end


%% Choose best neutral frames (one per vid)
if ~ismember(1, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupChooseBestNeutralFrames(pathTbl);
    end
end

%% Copy the chosen best neutral frame from another source (in case we already have them)
if ~ismember(2, sectionsToSkip) && ~isempty(copySourceProcDataDir_allSubj)
    for i = 1:length(subjNames)
        [srcPathTbl, ~] = loadPathTbls(copySourceProcDataDir_allSubj, subjNames{i});
        [pathTbl, ~] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        
        setupCopyBestNeutrFrParams(srcPathTbl.AUsFramesTblsFile, pathTbl.AUsFramesTblsFile)
    end
end

%% Prepare the delta videos (vs. one best neutral frame) for upper face ROI

if ~ismember(3, sectionsToSkip)
    isVsOneNeutrFrame = true;
        
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        if isNeutrROI
            setupPrepareDeltaVid(pathTbl.(trainingVidFileColName), pathTbl.(trainingDeltaOneFrVidFileColName),...
                pathTbl.upperFaceDir, pathTbl.AUsFramesTblsFile, isVsOneNeutrFrame, [], pathTbl.upperFaceAUsFramesTblsFile);
        else
            setupPrepareDeltaVid(pathTbl.(trainingVidFileColName), pathTbl.(trainingDeltaOneFrVidFileColName),...
                pathTbl.upperFaceDir, pathTbl.AUsFramesTblsFile, isVsOneNeutrFrame);
        end
    end
end

%% Convert the delta videos (vs. one best neutral frame) of upper face ROI to DB
if ~ismember(4, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupConvertVid2DB(pathTbl.(trainingDeltaOneFrVidFileColName), pathTbl.(dbRDir_DeltaOneFr_ColName));
    end
end
