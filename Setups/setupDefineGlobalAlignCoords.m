function setupDefineGlobalAlignCoords(neutralVidMeanImgDir, wholeSubjPathMetaDir)

vidNeutralAvgImgName = fullfile(neutralVidMeanImgDir, 'neutralVidMeanImg.png');
vidNeutralAvgImg = imread(vidNeutralAvgImgName);

[h,w] = size(vidNeutralAvgImg);

predefLandmarks = defineGlobalAlignCoords7Pnts(h, w);
outputView = imref2d(size(vidNeutralAvgImg));

if ~exist(wholeSubjPathMetaDir, 'dir')
  mkdir(wholeSubjPathMetaDir);
end

save(fullfile(wholeSubjPathMetaDir, 'globalAlignParams.mat'),...
    'predefLandmarks', 'outputView');


