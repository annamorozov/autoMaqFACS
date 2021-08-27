function FramesTblWcols = addSubjTrialCols2FramesTbl(FramesTbl)
% Add subject trial column to the frames table
    FramesTblWcols = [];

    if ~isempty(FramesTbl)
        [subjName, trialName] = cellfun(@getSubjTrialNameFromDB, FramesTbl.dbDir,...
            'UniformOutput', false);

        FramesTblWcols = [FramesTbl table(subjName, trialName)];
    end
end


function [subjName, trialName] = getSubjTrialNameFromDB(pathDB)
    %%Pay attention, this will work only to this specific dirs
    %%hierarchy! (subjName at 6th place in the path...)

    endout = regexp(pathDB, filesep, 'split');

    subjName = endout{:,6};
    trialName = endout{:,7};
end


