function setupPrepareTrainingVideos(pathTbl, isSavePreviewVid, namesToSkip)

% namesToSkip - optional param: a strings array with the names of the movie folders to
% skip, eg. ["G_10232_X1", "G_10232_X2"]

if nargin < 2 || nargin > 3
    error('usage: setupPrepareTrainingVideos(pathTbl, isSavePreviewVid[,namesToSkip]');
end

for i = 1:height(pathTbl)
    name = pathTbl.Properties.RowNames{i};
    
    if nargin > 2 && ~isempty(namesToSkip)
        if ismember(name, namesToSkip)
            fprintf('setupPrepareTrainingVideos: skipping %s', name);
            continue;
        end
    end
    
    %% Videos for training 
    load(pathTbl.AUsFramesTblsFile{i}, 'training_matchedTimes_tbl');
    
    [~, trainingVideoName, ~] = fileparts(pathTbl.trainingVidFile{i});
    
    % save all the training images to lossless compression video
    extractTrainingImgsFromVid(training_matchedTimes_tbl.Frame_n(1):training_matchedTimes_tbl.Frame_n(end),...
        pathTbl.vidMetaDataFile{i}, pathTbl.rawVidFile{i}, pathTbl.trainingDir{i}, trainingVideoName, false);

    % for easy preview: save all the training images to a compressed video
    if isSavePreviewVid
        editVideo(pathTbl.trainingVidFile{i}, pathTbl.trainingDir{i}, 'outputFormat', 'avi');
    end
end

