function setupGetVidNeutralAvgImg(trainingDirCol, AUsFramesTblsFileCol, trainingVidFileCol,...
    isOverrideExisting, nFrames2Truncate)

% nFrames2Truncate - optional param, number of frames to erase from the neutral sequence (from its start and its end),
% to ensure the elimination of other AUs from the sequence.

for i = 1:length(trainingDirCol)

    %TODO: consider saving figure
    vidNeutralAvgImgName = fullfile(trainingDirCol{i}, 'neutralVidMeanImg.png');

    if (exist(vidNeutralAvgImgName, 'file') ~= 2) || isOverrideExisting
        load(AUsFramesTblsFileCol{i}, 'AUs_all_tables', 'training_matchedTimes_tbl');

        if nargin > 4   % nFrames2Truncate
            vidNeutralAvgImg = getVidNeutralAvgImg(trainingVidFileCol{i}, AUs_all_tables,...
                training_matchedTimes_tbl, nFrames2Truncate);
        else
            vidNeutralAvgImg = getVidNeutralAvgImg(trainingVidFileCol{i}, AUs_all_tables,...
                training_matchedTimes_tbl);
        end
        
        imwrite(vidNeutralAvgImg, vidNeutralAvgImgName);
    end

end