function [tform, alignedImg, bApproved] = getAndApproveVidAlignTform(movingVid, movingVidMeanImg, movingLandmarkPnts,...
    fixedLandmarkPnts, outputView)

%% transform the moving mean img to the fixed mean img
[tform, alignedImg] = align2Imgs...
    (movingVidMeanImg, movingLandmarkPnts, fixedLandmarkPnts, outputView);


%% Verify the transformation on the 1st frame of the moving video according to the found transformation

fprintf('Going to verify the alignment transformation for video %s according to the found alignment parameters...\n', movingVid);

bApproved = verifyTformOn1stFrame(movingVid, tform, outputView);

