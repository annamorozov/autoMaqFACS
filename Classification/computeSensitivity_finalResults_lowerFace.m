%% Generalization of same subj, new vid - lower, KNN

clear;
classifResPath = '[path_to_classification_folder]\KNN__AUs_256_25616_25618i__sameSubjOneVidOut__sampSets__minLblOnTrainTest';
ROItype = 2;
isGener2NewVid = false;
isCVresCol = true; % Eiher same subj gener to new vid, or gener to new subj, all vids
allSetsTbl_Sensitivity = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype, isGener2NewVid, isCVresCol);
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity.mat'), 'allSetsTbl_Sensitivity');


%% Generalization to a new subj - lower, KNN 
clear;
classifResPath = '[path_to_classification_folder]\KNN_AUs_256_25616_25618i_oneSubjOut_sampSets_minLblsInTrainAndTest';
ROItype = 2;
isGener2NewVid = false; 
isCVresCol = true; % Eiher same subj gener to new vid, or gener to new subj, all vids
allSetsTbl_Sensitivity = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype, isGener2NewVid, isCVresCol);
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity.mat'), 'allSetsTbl_Sensitivity');


%% Generalization to new species - lower, KNN

clear;
classifResPath = '[path_to_classification_folder]\KNN_AUs_256_25616_25618i';
ROItype = 2;
[allSetsTbl_Sensitivity, allSetsTbl_Sensitivity_full] = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype);
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity.mat'), 'allSetsTbl_Sensitivity');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





