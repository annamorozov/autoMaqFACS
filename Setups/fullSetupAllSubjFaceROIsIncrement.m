function fullSetupAllSubjFaceROIsIncrement(procDataDir_allSubj, subjNames, copySourceProcDataDir_allSubj, sectionsToSkip)
% Create the ROIs

allSubjDirName = 'AllSubj';
allSubjMetaDir = fullfile(procDataDir_allSubj, allSubjDirName);

if nargin < 3   % copySourceProcDataDir_allSubj
    copySourceProcDataDir_allSubj = '';
end

if nargin < 4   % sectionsToSkip
    sectionsToSkip = [];
end

%% Create the mean neutral img for each subject

if ~ismember(1, sectionsToSkip)
    neutralVidMeanImgName = 'neutralVidMeanImg_aligned2PredefLoc.png';
    neutralSubjMeanImg = 'neutralSubjMeanImg_aligned2PredefLoc.png';

    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        meanSubjImg = getSubjNeutralMeanImg(pathTbl.trainingDir, neutralVidMeanImgName);
        imwrite(meanSubjImg, fullfile(wholeSubjPath.MetaDir, neutralSubjMeanImg));
    end
end

%% Create the mean neutral img for all subjects

if ~ismember(2, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    wholeSubjMetaPathList = {};

    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        % Concat. the meta dirs of all subjects
        wholeSubjMetaPathList = [wholeSubjMetaPathList; wholeSubjPath.MetaDir];
    end

    neutralAllSubjMeanImg = 'neutralAllSubjMeanImg_aligned2PredefLoc.png';
    allSubjMeanImg = getSubjNeutralMeanImg(wholeSubjMetaPathList, neutralSubjMeanImg);

    if ~exist(allSubjMetaDir, 'dir')
        mkdir(allSubjMetaDir);
    end

    imwrite(allSubjMeanImg, fullfile(allSubjMetaDir, neutralAllSubjMeanImg));
end

%% Define the ROIs of the mean neutral img of all subjects

% Define the ROIs
if ~ismember(3, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    setupDefineFaceROIs(allSubjMeanImg, allSubjMetaDir);
end

% Show the ROIs that are going to be cropped
if ~ismember(4, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupShowFaceROIsOn1stFrames(pathTbl.alignedVidFile, allSubjMetaDir);
        close all;
    end
end

%% Copy the ROIs and the mean neutral img of all subjects (in case we already have them)

if ~ismember(5, sectionsToSkip) && ~isempty(copySourceProcDataDir_allSubj)
    srcAllSubjMetaDir = fullfile(copySourceProcDataDir_allSubj, allSubjDirName);
    setupCopyFaceROIs(srcAllSubjMetaDir, allSubjMetaDir);
end

%% Crop the videos according to the defined ROIs
isConvertRGB2Gray = false;

if ~ismember(6, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupCropVids2FaceROIs(pathTbl.alignedVidFile, pathTbl.faceROIsDir, allSubjMetaDir,...
            pathTbl.upperFaceTrainingVidFile, pathTbl.lowerFaceTrainingVidFile,...
            pathTbl.leftEarTrainingVidFile, pathTbl.rightEarTrainingVidFile,...
            isConvertRGB2Gray);
    end
end

 