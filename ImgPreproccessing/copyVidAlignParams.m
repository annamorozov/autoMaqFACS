function copyVidAlignParams(sourceTrainingDir, targetTrainingDir) 

fSrcLandmarks = fullfile(sourceTrainingDir, 'faceLandmarks.mat');
fTgtLandmarks = fullfile(targetTrainingDir, 'faceLandmarks.mat');

fSrcTform = fullfile(sourceTrainingDir, 'tform2PredefLoc.mat');
fTgtTform = fullfile(targetTrainingDir, 'tform2PredefLoc.mat');


if ~copyfile(fSrcLandmarks, fTgtLandmarks)
    error('Couldnt copy %s file to %s', fSrcLandmarks, fTgtLandmarks);
end

if ~copyfile(fSrcTform, fTgtTform)
    error('Couldnt copy %s file to %s', fSrcTform, fTgtTform);
end
