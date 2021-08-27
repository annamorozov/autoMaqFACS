function setupParseVidMeta(pathTbl)
% Parse the video meta data: number of frames and time for each frame

for i = 1:height(pathTbl)
    [timesVec, framesNum] = getFramesTimes(pathTbl.rawVidFile{i});
    
    outputFolder = pathTbl.dataDir{i};
    
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end
    
    save(pathTbl.vidMetaDataFile{i} ,'timesVec','framesNum');
end