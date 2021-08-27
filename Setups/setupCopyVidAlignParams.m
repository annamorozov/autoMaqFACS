function setupCopyVidAlignParams(sourceTrainingDirCol, targetTrainingDirCol)

for i = 1:length(targetTrainingDirCol)
    srcTrnDir = '';
    
    if length(targetTrainingDirCol) == length(sourceTrainingDirCol)
        srcTrnDir = sourceTrainingDirCol{i};
    elseif length(sourceTrainingDirCol) == 1
        srcTrnDir = sourceTrainingDirCol{1};
    else
        error('Sizes missmatch beween the source and the target training dir columns!');
    end
    
    copyVidAlignParams(srcTrnDir, targetTrainingDirCol{i});
    
    fprintf('Finished copying the alignment params for training dir %s.\n', targetTrainingDirCol{i});
end

