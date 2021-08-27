function setupGetAlignVidTform(trainingDirCol, trainingVidFileCol, ...
    refAlignLandmarks, outputView)

% Get the transformation and prompt for approval

for i = 1:length(trainingDirCol)
        
    load(fullfile(trainingDirCol{i}, 'faceLandmarks.mat'), 'landmarkPnts');
    
    vidNeutralAvgImgName = fullfile(trainingDirCol{i}, 'neutralVidMeanImg.png');
    vidNeutralAvgImg = imread(vidNeutralAvgImgName);
    
    tform = [];
    bApproved = false;
    
    while ~bApproved
        [tform, alignedImg, bApproved] = getAndApproveVidAlignTform(trainingVidFileCol{i}, vidNeutralAvgImg, landmarkPnts,...
            refAlignLandmarks, outputView);
    
        if ~bApproved
            % Mark the landmarks again
            setupMarkFaceLandmarks(trainingDirCol(i), trainingVidFileCol(i));
        end
    end
    
    
    %% save
    imwrite(alignedImg, fullfile(trainingDirCol{i},'neutralVidMeanImg_aligned2PredefLoc.png'));
    save(fullfile(trainingDirCol{i}, 'tform2PredefLoc.mat'), 'tform');
end
