function extractTrainingImgsFromVid(framesNumsVec, vidMetaData, videoFullFileName, outputFolder, outputVidName, isSaveImg2Disc)

% Extracts all the frames continuously:
% starts at a given start frame and ends on a given end frame

%% Setup

if  isSaveImg2Disc
    imgFormatToSave = 'png';
end

fprintf('Going to extract training images from %s\n', videoFullFileName);

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

if ~exist(videoFullFileName, 'file')
	fprintf('File not found:\n%s\n', videoFullFileName);
    return;
end

load(vidMetaData, 'timesVec');
if isempty(timesVec)
    error('Failed to load timesVec %s.\n', vidMetaData);
end

%%
videoObject = VideoReader(videoFullFileName);

outputVidFullName = fullfile(outputFolder, outputVidName);
vw = VideoWriter(outputVidFullName, 'Archival');
open(vw);

frameIndx = 1;
nExtracted = 0;

while hasFrame(videoObject) && frameIndx <= framesNumsVec(end)
    % CurrentTime is the time of frame ***to be read***. 
    % Should be done here, because the CurrentTime will change after the frame reading
    frameCurrentTime = videoObject.CurrentTime; 
    vidFrame = readFrame(videoObject);
    
    if frameIndx >= framesNumsVec(1)
        %Sanity check
        if frameCurrentTime ~= timesVec(frameIndx)
            error('Failed to extract training frames from %s! videoObject and timesVec are not synced!', videoFullFileName);
        end
        
        % Extract the frame from the movie structure
        writeVideo(vw, vidFrame);
        
        nExtracted = nExtracted+1;
        if mod(nExtracted,1000) == 0
            fprintf('extractTrainingImgsFromVid: extracted %d images\n', nExtracted);
        end
        
        if isSaveImg2Disc
            % Construct an output image file name
            outputFileName = sprintf('Frame%6.6d.png', frameIndx);
            outputFullFileName = fullfile(outputFolder, outputFileName);

            % Write the image
            imwrite(vidFrame, outputFullFileName, imgFormatToSave);

            if ~exist(outputFullFileName, 'file')
                fprintf('Failed to write frame number: %d\nTerminating vidToImgs execution.\n', frameIndx);
                close(vw);
                return;
            end
        end
    end
   
    frameIndx = frameIndx + 1;
end

close(vw);

fprintf('extractTrainingImgsFromVid: %d frames were successfully written to %s\n', nExtracted, outputVidFullName);
