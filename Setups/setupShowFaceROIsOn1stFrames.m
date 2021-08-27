function setupShowFaceROIsOn1stFrames(trainingVidFileCol, wholeSubjPathMetaDir)

load(fullfile(wholeSubjPathMetaDir, 'FaceROIsParams.mat'), 'ROIsPositions');

for i = 1:length(trainingVidFileCol)
    showFaceROIsOn1stFrame(trainingVidFileCol{i}, ROIsPositions);
end
