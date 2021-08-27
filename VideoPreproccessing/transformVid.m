function transformVid(inputVid, outputVid, tform, outputView, isArchival)
% Apply a transformation on a video

if ~exist(inputVid, 'file')
	fprintf('File not found:\n%s\n', inputVid);
    return;
end

vr = VideoReader(inputVid);

if isArchival
    vw = VideoWriter(outputVid, 'Archival');
else
    vw = VideoWriter(outputVid);
end

open(vw);

fprintf('Going to align images from %s\n', inputVid);

frameIndx = 1;

while hasFrame(vr)
    vidFrame = readFrame(vr);

    alignedFrame = imwarp(vidFrame,tform,'OutputView',outputView);

    writeVideo(vw, alignedFrame);
    frameIndx = frameIndx + 1;
end

close(vw);

fprintf('transformVid: %d frames were successfully aligned and written to %s\n', frameIndx-1, outputVid);
