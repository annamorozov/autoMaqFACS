function vidNeutralAvgImg = getVidNeutralAvgImg(vidName, AUs_all_tables,...
    training_matchedTimes_tbl, nFrames2Truncate)

% nFrames2Truncate - optional param, number of frames to erase from the neutral sequence (from its start and its end),
% to ensure the elimination of other AUs from the sequence.

%% Find the neutral frames
fprintf('Going to get the neutral frames from the video %s for alignment...\n', vidName);

if nargin > 3   % nFrames2Truncate
    fprintf('%d frames will be truncated from the beginning and end of the neutral sequences.\n', nFrames2Truncate);
    
    [neutralFrames_TrainingVidIndx, ~] = ...
        getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl, nFrames2Truncate);
else
    [neutralFrames_TrainingVidIndx, ~] = ...
        getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl);
end

%neutralFramesIndx = find(neutralFrames_TrainingVidIndx);

fprintf('Finished getting the neutral frames from the video for alignment.\n');

%% Average the neutral frames (from the moving vid)
fprintf('Going to get the average image of the video for alignment neutral frames.\n');

if ~isempty(neutralFrames_TrainingVidIndx)
    vidNeutralAvgImg = getAvgImgFromVid(vidName, neutralFrames_TrainingVidIndx);
    %figure;imshow(vidNeutralAvgImg);title('Average moving video img'); 
else
    fprintf('No neutral frames found for %s. Going to generate all frames average image...', vidName);
    vidNeutralAvgImg = getAvgImgFromVid(vidName);
end

fprintf('Finished getting the average image of the video for alignment neutral frames.\n');
