function setupGetNeutralFramesInd(trainingDirCol, AUsFramesTblsFileCol, nFrames2Truncate)

% nFrames2Truncate - optional param, number of frames to erase from the neutral sequence (from its start and its end),
% to ensure the elimination of other AUs from the sequence.

for i = 1:length(trainingDirCol)
    load(AUsFramesTblsFileCol{i}, 'AUs_all_tables', 'training_matchedTimes_tbl');
    AUsAndFramesTbls = load(AUsFramesTblsFileCol{i});
    
    if nargin > 2   % nFrames2Truncate
        [neutralFrames_TrainingVidIndx,...
         neutralFrames_GlobalIndx     ] = getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl, nFrames2Truncate);
        
        % For save
        AUsAndFramesTbls.neutralFramesInd.neutralFrames_TrainingVidIndx = neutralFrames_TrainingVidIndx;
        AUsAndFramesTbls.neutralFramesInd.neutralFrames_GlobalIndx      = neutralFrames_GlobalIndx;
        AUsAndFramesTbls.neutralFramesInd.nFrames2Truncate              = nFrames2Truncate;
        
    else
        [neutralFrames_Abs_TrainingVidIndx,...
         neutralFrames_Abs_GlobalIndx     ] = getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl);
     
        % For save
        AUsAndFramesTbls.neutralFramesInd.neutralFrames_Abs_TrainingVidIndx = neutralFrames_Abs_TrainingVidIndx;
        AUsAndFramesTbls.neutralFramesInd.neutralFrames_Abs_GlobalIndx      = neutralFrames_Abs_GlobalIndx;
    end
    
    save(AUsFramesTblsFileCol{i}, '-struct', 'AUsAndFramesTbls');
end