function cropVidRectROI(inputVidFullName, outputFolder, outputVidNames, rectPositions, isConvertRGB2Gray, isArchival)
% Crop videos to rectangular ROIs
% isArchival - optional param. 'true' by default.

%% Setup
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

if ~exist(inputVidFullName, 'file')
	fprintf('cropVidRectROI: File not found:\n%s\n', inputVidFullName);
    return;
end

if nargin < 6 % isArchival
    isArchival = true;
end

nROIs = length(rectPositions);


fprintf('cropVidRectROI: Going to crop %d ROIs from frames in the video %s\n', nROIs, inputVidFullName);

%%

videoObject = VideoReader(inputVidFullName);
vw = {};

for i = 1:nROIs
    outputVidFullName = outputVidNames{i};
    [thisOutDir,~,~] = fileparts(outputVidFullName);
    if ~exist(thisOutDir, 'dir')
        mkdir(thisOutDir);
    end
    
    if isArchival
        vw{i} = VideoWriter(outputVidFullName, 'Archival');
    else
        vw{i} = VideoWriter(outputVidFullName);
    end
    open(vw{i});
end

nCropped = 0;

while hasFrame(videoObject)
    img = readFrame(videoObject);
 
    if isConvertRGB2Gray
        img = rgb2gray(img);
    end
    
    for i = 1:nROIs
        % Crop according to rectPositions and write to video
        croppedImage = imcrop(img, rectPositions{i});
        writeVideo(vw{i}, croppedImage);
    end
    
    nCropped = nCropped + 1; 
    
    if mod(nCropped,1000) == 0
        fprintf('cropVidRectROI: %d frames cropped\n', nCropped);
    end
end

for i = 1:nROIs
    close(vw{i});
end

fprintf('cropVidRectROI: Finished cropping %d ROIs. Saved video to %s. Total cropped images = %d\n', nROIs, outputVidFullName, nCropped);

