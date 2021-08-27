function nFrames = getVidLengthEstimation(videoReaderObj)

nFrames = ceil(videoReaderObj.FrameRate*videoReaderObj.Duration);