function setupDefineFaceROIs(meanAlignNeutrImg, wholeSubjPathMetaDir)
% Define the ROIs of the mean neutral img of all subjects

[ROIsPositions, BWmasks, totMask] = defineFaceRegionsROIs(meanAlignNeutrImg);
save(fullfile(wholeSubjPathMetaDir, 'FaceROIsParams.mat'), 'ROIsPositions', 'BWmasks', 'totMask');
