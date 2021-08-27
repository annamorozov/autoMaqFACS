function setupPrepareDeltaVid(trainingVidFileCol, trainingDeltaVidFileCol,...
    trainingDirCol, AUsAndFramesTblsCol, isVsOneNeutrFrame, vsNeutralAbs_FileIndVec, AUsAndFramesTblsCol_bestNeutrFrROI)

% Create the delta videos

% vsNeutralAbs_FileIndVec - optional param: if the vector is not empty, 
% the neutral frame index of those videos from trainingVidFileCol will be
% taken from absolute neutral frames and not the truncated indices. 

if length(trainingVidFileCol) ~= length(trainingDeltaVidFileCol)
    error('Different length of training videos column and dleta training videos column!');
end

for i = 1:length(trainingVidFileCol)    
    inputVid = trainingVidFileCol{i};
    outpuVid = trainingDeltaVidFileCol{i};
    
    load(AUsAndFramesTblsCol{i}, 'neutralFramesInd', 'training_matchedTimes_tbl');
    
    neutrFr_TrainVidIndx = neutralFramesInd.neutralFrames_Abs_TrainingVidIndx;
    
    if nargin > 5 && ~isempty(vsNeutralAbs_FileIndVec)   % vsNeutralAbs_FileIndVec
        if ismember(i, vsNeutralAbs_FileIndVec)
            neutrFr_TrainVidIndx = neutralFramesInd.neutralFrames_Abs_TrainingVidIndx;
        end
    end
    
    if isVsOneNeutrFrame
        bestNeutralFr_localInd = neutralFramesInd.bestNeutralFr_localInd;
        
        if nargin > 6 && ~isempty(AUsAndFramesTblsCol_bestNeutrFrROI)
            
            neutralFramesInd_ROI = load(AUsAndFramesTblsCol_bestNeutrFrROI{i});
            bestNeutralFr_localInd = neutralFramesInd_ROI.bestNeutralFr_localInd;
            
            neutralFrames_trainVid_ROI = load(AUsAndFramesTblsCol_bestNeutrFrROI{i}, 'neutralFrames_trainVid_ROI');
            neutrFr_TrainVidIndx = neutralFrames_trainVid_ROI.neutralFrames_trainVid_ROI;
        end
        
        [diffImgsTbl, missingFrames] = vid2DeltaVsNeutral(inputVid, outpuVid,...
            neutrFr_TrainVidIndx, bestNeutralFr_localInd);
    else
        [diffImgsTbl, missingFrames] = vid2DeltaVsNeutral(inputVid, outpuVid,...
            neutrFr_TrainVidIndx);
    end
    
    deltaVidMeta.diffImgsTbl = diffImgsTbl;
    deltaVidMeta.missingFrames = missingFrames;
    
    if isVsOneNeutrFrame
        save(fullfile(trainingDirCol{i},'deltaOneFrVidMeta.mat'), 'deltaVidMeta');
    else
        save(fullfile(trainingDirCol{i},'deltaVidMeta.mat'), 'deltaVidMeta');
    end
end