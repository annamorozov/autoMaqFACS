function setupValidateOrigNeutralCoding(pathTbl)

for i = 1:height(pathTbl)
    trainingVid = pathTbl.trainingVidFile{i};
    [trainDir, trainName, ~] = fileparts(trainingVid);
    
    load(pathTbl.AUsFramesTblsFile{i}, 'AUs_all_tables', 'training_matchedTimes_tbl');
    
    %% Extract only neutral frames from the training vid
    
    neutralVid = fullfile(trainDir, sprintf('%s_Neutral.avi', trainName));

    [neutralFrames_TrainingVidIndx, ~] = ...
        getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl);

    extractSpecificFramesFromVid(trainingVid, neutralVid, 'framesIndVec', ...
        neutralFrames_TrainingVidIndx);
end