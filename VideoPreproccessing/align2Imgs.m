function [tform, alignedImg] = align2Imgs...
    (movingImg, movingLandmarkPnts, fixedLandmarkPnts, outputView)

% Align 2 images (one image is the "moving" and the other is the "fixed")

tform = fitgeotrans(movingLandmarkPnts,fixedLandmarkPnts,'affine');
alignedImg = imwarp(movingImg,tform,'OutputView',outputView);


