function setupMarkFaceLandmarks(trainingDirCol, vidName4Print)
% Mark 7 landmark points on the mean neutral image

for i = 1:length(trainingDirCol)
    vidNeutralMeanImgName = fullfile(trainingDirCol{i}, 'neutralVidMeanImg.png');
    vidNeutralMeanImg = imread(vidNeutralMeanImgName);

    %% moving image landmarks
    fprintf('Going to prepare the face ladmarks of the video %s for alignment...\n', vidName4Print{i});

    landmarkPnts = markFaceLandmarks(vidNeutralMeanImg);

    fprintf('Finished preparing the face ladmarks of the video for alignment.\n');
    
    save(fullfile(trainingDirCol{i}, 'faceLandmarks.mat'), 'landmarkPnts');
end