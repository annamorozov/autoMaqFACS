function [diffImgsTbl, missingFrames] = vid2DeltaVsNeutral(inputVid, outpuVid,...
    neutralFrames_TrainingVidIndx, bestNeutralFr_localInd, isArchival)

% Create the delta video (subtract the neutral frame from all the frames)

% bestNeutralFr_localInd - optional param: 
%                          the diff is only with one neutral frame (the chosen one)
% isArchival -             optional param. 'true' by default.


if nargin < 5 % isArchival
    isArchival = true;
end

[mov, ~] = vid2struct(inputVid);

if isArchival
    vw = VideoWriter(outpuVid, 'Archival');
else
    vw = VideoWriter(outpuVid);
end

open(vw);

len = length(mov);

closestIndArr = zeros(len,1);
isPrevArr = zeros(len,1);
missingFrames = [];

if nargin == 3
    fprintf('Going to make delta video vs. closest neutral frames from %s...\n', inputVid);
else    % bestNeutralFr_localInd
    fprintf('Going to make delta video vs. one neutral frame from %s...\n', inputVid);
end

for i=1:len
    if nargin == 3 
        [closestInd, isPrev] = getClosestNeutralFrameInd(i, neutralFrames_TrainingVidIndx);

        if closestInd == 0
            missingFrames = [missingFrames; i];
            continue;
        end
    else    % bestNeutralFr_localInd
        % Example: 9th frame in the neutral frames video is also the
        % 9th index in neutralFrames_TrainingVidIndx
        closestInd = neutralFrames_TrainingVidIndx(bestNeutralFr_localInd);
        isPrev = (closestInd < i);
    end
    
    closestIndArr(i) = closestInd;
    isPrevArr(i) = isPrev;
    
    neutralFrame = mov(closestInd).cdata;
    if size(neutralFrame, 3) == 3
        neutralFrame = rgb2gray(neutralFrame);
    end
    
    thisFrame = mov(i).cdata;
    if size(thisFrame, 3) == 3
        thisFrame = rgb2gray(thisFrame);
    end
    
    diffImg = imsubtract(thisFrame,neutralFrame);
    
    writeVideo(vw, diffImg);
end

close(vw);
clear 'mov';

iFramesArr = 1:len;
diffImgsTbl = table(iFramesArr', closestIndArr, isPrevArr, 'VariableNames',...
    {'iTrainFr', 'iClosestNeutrFr', 'isPrev'});

fprintf('Delta video was successfully written to %s.\n', outpuVid);
