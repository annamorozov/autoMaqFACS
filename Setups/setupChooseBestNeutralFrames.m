function setupChooseBestNeutralFrames(pathTbl)

for i = 1:height(pathTbl)
    
    trainingVid = pathTbl.trainingVidFile{i};
    [trainDir, trainName, ~] = fileparts(trainingVid);
    neutralVid = fullfile(trainDir, sprintf('%s_Neutral.avi', trainName));
    
    frameNum = chooseBestNeutralFrame(neutralVid);
    
    % Save
    AUsAndFramesTbls = load(pathTbl.AUsFramesTblsFile{i});
    AUsAndFramesTbls.neutralFramesInd.bestNeutralFr_localInd = frameNum;
    save(pathTbl.AUsFramesTblsFile{i}, '-struct', 'AUsAndFramesTbls');
end