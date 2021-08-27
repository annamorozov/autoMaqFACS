function [neutralFrames_TrainingVidIndx, neutralFrames_GlobalIndx] = ...
    getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl, nFrames2Truncate)

    % Returns the local (relative to training vid) and global (relative to original vid)
    % numbers of frames with neutral expression

    % nFrames2Truncate - optional param, number of frames to erase from the neutral sequence (from its start and its end),
    % to ensure the elimination of other AUs from the sequence.

    Frame_n_AllAus = [];

    % The logic:
    % Concatenate all labeled frames, sort them and filter to unique.
    % Neutral frames are the ones that are in the training frames list but not
    % in the labeled filtered frames list. 

    for i=1:length(AUs_all_tables)
        Frame_n = [];

        if iscell(AUs_all_tables{i}.AU_matchedTimes_tbl)
            Frame_n = AUs_all_tables{i}.AU_matchedTimes_tbl{1}.Frame_n;
        elseif istable(AUs_all_tables{i}.AU_matchedTimes_tbl)
            Frame_n = AUs_all_tables{i}.AU_matchedTimes_tbl.Frame_n;
        else
            error('The type of AU_matchedTimes_tbl in row %d is not cell array and not table!', i);
        end

        Frame_n_AllAus = [Frame_n_AllAus; Frame_n];
    end

    trainingFrames = training_matchedTimes_tbl.Frame_n(1):...
        training_matchedTimes_tbl.Frame_n(end);
    
    if ismember('lastFrForNeutralFr', training_matchedTimes_tbl.Properties.VariableNames)
        if ~isempty(training_matchedTimes_tbl.lastFrForNeutralFr(1))
                lastFrForNeutr = training_matchedTimes_tbl.lastFrForNeutralFr(1);
                
                if lastFrForNeutr <= training_matchedTimes_tbl.Frame_n(end)
                    
                    trainingFrames = training_matchedTimes_tbl.Frame_n(1):...
                        lastFrForNeutr;
                end
        end
    end

    Lia = ismember(trainingFrames, Frame_n_AllAus);

    % Neutral expression frames are the training frames that are not
    % members of the frames with AUs (all the specifically labeled frames)
    neutralFrames_GlobalIndx = trainingFrames(~Lia);

    neutralFrames_TrainingVidIndx_train = ~Lia;   % Logical array (1 or 0 in the corresponding array indices)  
    neutralFrames_TrainingVidIndx = find(neutralFrames_TrainingVidIndx_train);

    if nargin > 2   % nFrames2Truncate
        neutralFrames_TrainingVidIndx = truncateFrames(neutralFrames_TrainingVidIndx, nFrames2Truncate);
        neutralFrames_GlobalIndx = truncateFrames(neutralFrames_GlobalIndx, nFrames2Truncate);
    end

end

function framesAfterTruncInd = truncateFrames(framesInd, nFrames2Truncate)

    % The function truncates [nFrames2Truncate] frames from the start and
    % the end of the frames sequences

    framesDiff =diff(framesInd);
    seqStartInd = find([framesDiff inf]>1);
    seqLength = diff([0 seqStartInd]); % length of the sequences
    seqEndInd = cumsum(seqLength);  % endpoints of the sequences

    seqStartInd = seqEndInd + 1 - seqLength;

    newStartInd = seqStartInd + nFrames2Truncate;
    newEndInd = seqEndInd - nFrames2Truncate;
    
    if length(newStartInd) ~= length(newEndInd)
        error('The length of start and end indices are different!');
    end

    newIndSeqs = [];
    for i = 1:length(newStartInd)
        newIndSeqs = [newIndSeqs newStartInd(i) : newEndInd(i)];
    end

    framesAfterTruncInd = framesInd(newIndSeqs);

end

