function exper_fullSetupAllSubjFaceROIsIncrement(procDataDir_allSubj, subjNames, cropROIsParamsDir)
% Crop the videos according to defined ROIs

% ROIs crop
isConvertRGB2Gray = false;

for i = 1:length(subjNames)
    [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

    setupCropVids2FaceROIs(pathTbl.alignedVidFile, pathTbl.faceROIsDir, cropROIsParamsDir,...
        pathTbl.upperFaceTrainingVidFile, pathTbl.lowerFaceTrainingVidFile,...
        pathTbl.leftEarTrainingVidFile, pathTbl.rightEarTrainingVidFile,...
        isConvertRGB2Gray);
end
