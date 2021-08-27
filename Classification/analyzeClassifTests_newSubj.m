%% New subj (Rhesus) - KNN

% Analyze the classifiers for generalization subject-wise:

% Upper - all dirs
ROItype = 1;
resDir = '[path_to_classification_folder]\KNN__AU_1_2__AU_43__neutralAbs__oneSubjOut_sampSets_minLblsInTrainAndTest';
load(fullfile(resDir, 'trainingParams.mat'), 'setsResSaveDirList', 'nSets');

sumDirTbl_GenerSensSubjWise_allTestSets(setsResSaveDirList, nSets, ROItype);
allSetsTbl_Sensitivity_full_subjWise = sortResFolderTbls_Sensitivity_allSets_subjWise(resDir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lower - all dirs
ROItype = 2;
resDir = '[path_to_classification_folder]\KNN_AUs_256_25616_25618i_oneSubjOut_sampSets_minLblsInTrainAndTest';
load(fullfile(resDir, 'trainingParams.mat'), 'setsResSaveDirList', 'nSets');

sumDirTbl_GenerSensSubjWise_allTestSets(setsResSaveDirList, nSets, ROItype);
allSetsTbl_Sensitivity_full_subjWise = sortResFolderTbls_Sensitivity_allSets_subjWise(resDir);

