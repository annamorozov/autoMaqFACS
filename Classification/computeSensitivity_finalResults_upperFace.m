%% Generalization of same subj, new vid - upper, KNN

clear;
classifResPath = '[path_to_classification_folder]\KNN__AU_1_2__AU_43__neutralAbs__sameSubjOneVidOut__sampSets_minLblsTrainTest';
ROItype = 1;
isGener2NewVid = false;
isCVresCol = true; % Eiher same subj gener to new vid, or gener to new subj, all vids
allSetsTbl_Sensitivity = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype, isGener2NewVid, isCVresCol);
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity.mat'), 'allSetsTbl_Sensitivity');


%% Generalization to a new subj - upper, KNN 
clear;
classifResPath = '[path_to_classification_folder]\KNN__AU_1_2__AU_43__neutralAbs__oneSubjOut_sampSets_minLblsInTrainAndTest';
ROItype = 1;
isGener2NewVid = false; 
isCVresCol = true; % Eiher same subj gener to new vid, or gener to new subj, all vids
allSetsTbl_Sensitivity = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype, isGener2NewVid, isCVresCol);
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity.mat'), 'allSetsTbl_Sensitivity');


%% Generalization to new species - upper, KNN

clear;
classifResPath = '[path_to_classification_folder]\KNN__AU_1_2__AU_43__neutralAbs';
ROItype = 1;
[allSetsTbl_Sensitivity, allSetsTbl_Sensitivity_full] = sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype);
save(fullfile(classifResPath, 'allSetsTbl_Sensitivity.mat'), 'allSetsTbl_Sensitivity');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





