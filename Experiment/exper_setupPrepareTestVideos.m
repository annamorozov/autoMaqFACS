function exper_setupPrepareTrainingVideos(pathTbl, globalAlignParamsDir, isSavePreviewVid)

% Resize params
load(fullfile(globalAlignParamsDir, 'globalAlignParams.mat'), 'outputView');

for i = 1:height(pathTbl)
    vr = VideoReader(pathTbl.rawVidFile{i});
    [padRows, padCols] = getImgPad2FitDatasetSize(vr.Width, vr.Height, outputView);
    save(fullfile(pathTbl.trainingDir{i}, 'sizePadParams.mat'), 'padRows', 'padCols');

    % Resize the whole video
    editVideo(pathTbl.rawVidFile{i}, pathTbl.trainingDir{i}, 'padRows', padRows, 'padCols',...
        padCols, 'outVidName', pathTbl.trainingVidFile{i}, 'isArchival', true);

    % for easy preview: save all the training images to a compressed video
    if isSavePreviewVid
        editVideo(pathTbl.trainingVidFile{i}, pathTbl.trainingDir{i}, 'outputFormat', 'avi');
    end
end



