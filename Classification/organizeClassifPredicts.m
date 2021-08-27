function allPredictions = organizeClassifPredicts(classifResultPath, isSaveInCVO,...
    isRestrictTestFrames)

cp = load(classifResultPath);

allPredictions = cell(height(cp.CVO.sourceTbl),1);

for i = 1:length(cp.CVO.test)
    thisPredInd = cp.CVO.test{i};
    
    % Sanity check
    if any(find(~cellfun(@isempty,allPredictions(thisPredInd))))
        error('Error in indices while summarizing predictions of %s',...
            classifResultPath);
    end
    
    allPredictions(thisPredInd) = cp.CVO.classifPredictions{i};
end

if ~isRestrictTestFrames
    % Sanity check
    if any(find(cellfun(@isempty,allPredictions)))
        error('Error in indices while summarizing predictions of %s',...
            classifResultPath);
    end
end

if isSaveInCVO
    cp.CVO.allPredictions = allPredictions;
    save(classifResultPath, '-struct', 'cp')
end
    

