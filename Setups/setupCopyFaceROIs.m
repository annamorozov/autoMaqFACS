function setupCopyFaceROIs(srcAllSubjMetaDir, tgtAllSubjMetaDir)

if ~exist(tgtAllSubjMetaDir, 'dir')
  mkdir(tgtAllSubjMetaDir);
end

srcFaceROIsParams = fullfile(srcAllSubjMetaDir, 'FaceROIsParams.mat');
tgtFaceROIsParams = fullfile(tgtAllSubjMetaDir, 'FaceROIsParams.mat');

srcNeutralVidMeanImg = fullfile(srcAllSubjMetaDir, 'neutralAllSubjMeanImg_aligned2PredefLoc.png');
tgtNeutralVidMeanImg = fullfile(tgtAllSubjMetaDir, 'neutralAllSubjMeanImg_aligned2PredefLoc.png');

if ~copyfile(srcFaceROIsParams, tgtFaceROIsParams)
    error('Couldnt copy %s file to %s', srcFaceROIsParams, tgtFaceROIsParams);
end

if ~copyfile(srcNeutralVidMeanImg, tgtNeutralVidMeanImg)
    error('Couldnt copy %s file to %s', srcNeutralVidMeanImg, tgtNeutralVidMeanImg);
end

fprintf('Finished copying face ROI params for all subjects dir %s.\n', tgtAllSubjMetaDir);
