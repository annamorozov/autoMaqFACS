function [mov, frameRate]  = vid2struct(inputVideo)

Video=VideoReader(inputVideo);
frameRate = Video.FrameRate;

nFrames = getVidLengthEstimation(Video);
vidHeight = Video.Height;
vidWidth = Video.Width;

mov(1:nFrames) =struct('cdata', zeros(vidHeight, vidWidth, 1, 'uint8'),'colormap', []);

percent10 = round((10*nFrames)/100);

fprintf('Start loading the video %s to struct...\n', inputVideo);

i=1;
while hasFrame(Video) 
    vidFrame = readFrame(Video);
    mov(i).cdata = vidFrame;
    
    if round(mod(i, percent10)) == 0
        fprintf('\n%d percent loaded', (i/percent10)*10);
    end
    
    i = i+1;
end
fprintf('\n');

fprintf('Finished loading video %s .\n', inputVideo);
