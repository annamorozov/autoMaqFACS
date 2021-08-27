%% Same subj (Rhesus) - KNN
% Analyze the classifiers for generalization subject-wise:

% Upper - all dirs
ROItype = 1;
resDir = '[path_to_classification_folder]\KNN__AU_1_2__AU_43__neutralAbs__sameSubjOneVidOut__sampSets_minLblsTrainTest';

nSets = 3;
for i=1:nSets
    setsResSaveDirList{i} = fullfile(resDir, sprintf('sampSet_%d',i));
end

isGenerateNewCVpart = true;
sumDirTbl_GenerSensSubjWise_allTestSets(setsResSaveDirList, nSets, ROItype, isGenerateNewCVpart);

allSetsTbl_Sensitivity_full_subjWise = sortResFolderTbls_Sensitivity_allSets_subjWise(resDir);


% Lower - all dirs
ROItype = 2;
resDir = '[path_to_classification_folder]\KNN__AUs_256_25616_25618i__sameSubjOneVidOut__sampSets__minLblOnTrainTest';

nSets = 3;
for i=1:nSets
    setsResSaveDirList{i} = fullfile(resDir, sprintf('sampSet_%d',i));
end

isGenerateNewCVpart = true;
sumDirTbl_GenerSensSubjWise_allTestSets(setsResSaveDirList, nSets, ROItype, isGenerateNewCVpart);

allSetsTbl_Sensitivity_full_subjWise = sortResFolderTbls_Sensitivity_allSets_subjWise(resDir);

