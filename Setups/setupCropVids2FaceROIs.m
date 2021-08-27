function setupCropVids2FaceROIs(alignedVidFileCol, faceROIsDirCol, wholeSubjPathMetaDir,...
    upFaceTrainVidFileCol, lowFaceTrainVidFileCol, lEarTrainVidFileCol, rEarTrainVidFileCol,...
    isConvertRGB2Gray)

% Crop the videos according to defined ROIs

load(fullfile(wholeSubjPathMetaDir, 'FaceROIsParams.mat'), 'ROIsPositions');

for i = 1:length(alignedVidFileCol)
    
    outputVidNames = {upFaceTrainVidFileCol{i}; lowFaceTrainVidFileCol{i};...
        lEarTrainVidFileCol{i}; rEarTrainVidFileCol{i}};

    % Crop the ROIs to separate training videos
    cropVidRectROI(alignedVidFileCol{i}, faceROIsDirCol{i}, outputVidNames,...
        ROIsPositions, isConvertRGB2Gray);

end
