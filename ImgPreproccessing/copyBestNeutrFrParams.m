function copyBestNeutrFrParams(sourceAUsFramesTblsFile, targetAUsFramesTblsFile) 

if exist(sourceAUsFramesTblsFile, 'file') ~= 2    
    error('%s file doesnt exist!', sourceAUsFramesTblsFile);
end

if exist(targetAUsFramesTblsFile, 'file') ~= 2
    error('%s file doesnt exist!', targetAUsFramesTblsFile);
end

% Save
srcAUsAndFramesTbls = load(sourceAUsFramesTblsFile);
frameNum = srcAUsAndFramesTbls.neutralFramesInd.bestNeutralFr_localInd;

AUsAndFramesTbls = load(targetAUsFramesTblsFile);
AUsAndFramesTbls.neutralFramesInd.bestNeutralFr_localInd = frameNum;
save(targetAUsFramesTblsFile, '-struct', 'AUsAndFramesTbls');
