function setupSortResFolderTbls_Sensitivity_allSets_holdoutValid(classifResPath, ROItype, validDirName)

if nargin < 3   % validDirName
    validDirName = 'validation_80_20';
end

isGener2NewVid = false;
isCVresCol = true;
isGener2NewSubj = false;
isHoldoutValid = true;
isHoldoutValid_Peaks = false;

[allSetsTbl_Sensitivity, allSetsTbl_Sensitivity_full] = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype,...
    isGener2NewVid, isCVresCol, isGener2NewSubj, isHoldoutValid, isHoldoutValid_Peaks, validDirName);

save(fullfile(classifResPath, 'allSetsTbl_Sensitivity_holdoutValid.mat'), 'allSetsTbl_Sensitivity');
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity_full_holdoutValid.mat'), 'allSetsTbl_Sensitivity_full');




