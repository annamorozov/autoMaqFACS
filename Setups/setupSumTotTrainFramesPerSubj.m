function nTotTrainFrames = setupSumTotTrainFramesPerSubj(AUsFramesTblsFileCol, subjMetaDir)

% The function calculates the total of the training frames per subject

nTotTrainFrames = 0;

for i = 1:length(AUsFramesTblsFileCol)
    load(AUsFramesTblsFileCol{i}, 'training_matchedTimes_tbl');
    
    nTrainFr_vid = training_matchedTimes_tbl.Frame_n(end) -...
        training_matchedTimes_tbl.Frame_n(1) + 1;
    
    nTotTrainFrames = nTotTrainFrames + nTrainFr_vid;
end

save(fullfile(subjMetaDir,'nTotTrainFrames.mat'), 'nTotTrainFrames');

