function setupAlignVid2Ref(trainingDirCol, trainingVidFileCol, alignedVidFileCol, outputView, isSavePreviewVid)
% Apply transformations on videos

for i = 1:length(trainingDirCol)
    
    load(fullfile(trainingDirCol{i}, 'tform2PredefLoc.mat'), 'tform');
    
    %% transform the moving video according to the found transformation

    fprintf('Going to transform the video %s according to the found alignment parameters...\n', trainingDirCol{i});

    isArchival = true;
    transformVid(trainingVidFileCol{i}, alignedVidFileCol{i}, tform, outputView, isArchival);
    
    % for easy preview: save all the aligned images to a compressed video
    if isSavePreviewVid
        editVideo(alignedVidFileCol{i}, trainingDirCol{i}, 'outputFormat', 'avi');
    end
end
