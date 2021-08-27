function [timesVec, framesNum] = getFramesTimes(videoFullFileName)

videoObject = VideoReader(videoFullFileName);
videoObject.CurrentTime = 0;

numFramesEst = ceil(videoObject.FrameRate*videoObject.Duration);
timesVec = zeros(1, numFramesEst);
i = 1;

fprintf('getFramesTimes: Started getting frames times for video %s ...\n', videoFullFileName);

% videoObject.CurrentTime - Location from the start of the file of the current
%                           frame ***to be read*** in seconds. 
while hasFrame(videoObject)
    timesVec(i) = videoObject.CurrentTime;
    
    readFrame(videoObject);
    
    if(mod(i,100) == 0)
        fprintf('getFramesTimes: processed %d frames\n', i);
    end
    i = i+1;
end

framesNum = i-1;

fprintf('getFramesTimes: Finished getting frames times for video %s .\n', videoFullFileName);

end
