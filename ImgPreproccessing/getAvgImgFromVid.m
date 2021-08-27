function avgImg = getAvgImgFromVid(inputVid, frames2include)

% frames2include - oprional param with the frames indices to include in the
% avg. If not specified - all the frames will be taken into the avg.

%Works in grayscale

vr = VideoReader(inputVid);
nFrames = 0;
iFrame = 1;
imgSum = zeros(vr.Height,vr.Width);  %double

while hasFrame(vr) 
    vidFrame = readFrame(vr);
    iFrame = iFrame + 1;
    
    if nargin == 2  % frames2include
        if iFrame > max(frames2include)
            break;
        end
        
        if ~any(ismember(iFrame, frames2include))
            continue;
        end
    end
    
    nChannels = size(vidFrame,3);
    
    if nChannels ~= 1
        vidFrameGray = rgb2gray(vidFrame);
    else
        vidFrameGray = vidFrame;
    end
    
    imgSum = imgSum + double(vidFrameGray);
    nFrames = nFrames + 1;
end

avgImg = imgSum/nFrames;
avgImg = uint8(avgImg);
%figure;imshow(refImgMean);title('Average'); 