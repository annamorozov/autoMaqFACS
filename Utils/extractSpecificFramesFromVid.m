function extractSpecificFramesFromVid(inputVid, outputVid, varargin)

% Creates a video from the specified frames

% Optional args:
% 'framesTrain' - vector in the length of the video, specifying for each
%                 frame whether to include it or not (1 or 0).
%                 Example: [1 0 0 1 0]
% 'framesIndVec' - vector specifying the indices of the frames to include.
%                  Example: [2 101 6009 8000]    
% Each time only one of these args may be used.

%% Parse the input

minArgs=4;
maxArgs=4;
narginchk(minArgs,maxArgs)

vr = VideoReader(inputVid);
nFramesEst = getVidLengthEstimation(vr);

p = inputParser;

checkFramesTrain  = @(x) (~any((x~=1)&(x~=0)) & (length(x) < nFramesEst+vr.FrameRate));
checkFramesIndVec = @(x) all(ismember(x,1:(nFramesEst+vr.FrameRate)));


% The default is all frames
defaultFramesTrain = ones(1, nFramesEst);            
defaultFramesIndVec = 1:nFramesEst; 

addRequired(p,'inputVid',@ischar);
addRequired(p,'outputVid',@ischar);

addParameter(p,'framesTrain',defaultFramesTrain,checkFramesTrain);
addParameter(p,'framesIndVec',defaultFramesIndVec,checkFramesIndVec);

parse(p,inputVid,outputVid,varargin{:});

disp(['Input video file: ',p.Results.inputVid]);
disp(['Output video file: ', p.Results.outputVid]);

%%
if ~exist(inputVid, 'file')
	fprintf('File not found:\n%s\n', inputVid);
    return;
end

vw = VideoWriter(outputVid);
open(vw);

frameIndx = 1;

while hasFrame(vr) 
   % Extract the frame from the movie structure
    vidFrame = readFrame(vr);

    if ~ismember('framesTrain', p.UsingDefaults)
        if frameIndx > length(p.Results.framesTrain)
            close(vw);
            error('framesTrain must be of the same length as the video %s!', inputVid);
        end
            
        if p.Results.framesTrain(frameIndx)     
            writeVideo(vw, vidFrame);
        end
    elseif ~ismember('framesIndVec', p.UsingDefaults)
        if any(ismember(p.Results.framesIndVec,frameIndx))     
            writeVideo(vw, vidFrame);
        end 
    else
        close(vw);
        error('One of the optional args (framesTrain or framesIndVec) must be chosen!')
    end

    frameIndx = frameIndx + 1;
end

close(vw);

if ~ismember('framesTrain', p.UsingDefaults)
    if frameIndx-1 ~= length(p.Results.framesTrain)
        error('The length of input video %s and the framesTrain are not equal!', inputVid);
    end
end

