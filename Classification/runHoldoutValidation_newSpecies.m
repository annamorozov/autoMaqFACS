%% Upper face - KNN

% subj D
classifResPath = '[path_to_classification_folder]\KNN__AU_1_2__AU_43__neutralAbs';
validateHoldout_80_20_newSpecies(classifResPath);

validResDirName = 'val8020';
% Solves the problem of cut file names, in case the path was too long
renameCorruptedMatFiles_allSampSets(classifResPath, validResDirName);

setupSumKnnClassifRes_allTestSets_holdoutValid(classifResPath, false, validResDirName);

% Find the best model parameters according to the holdout validation (on validation set)
ROItype = 1;
setupSortResFolderTbls_Sensitivity_allSets_holdoutValid(classifResPath, ROItype, validResDirName);

% You need to save the model with the selected parameters in [path_to_selected_model]. 
% Evaluate the final model on the test set
model_path = '[path_to_selected_model]';
holdoutTestPerfRes = testHoldout_80_20_file(model_path);


%% Lower face - KNN

% subj D
classifResPath = '[path_to_classification_folder]\KNN_AUs_256_25616_25618i';
validateHoldout_80_20_newSpecies(classifResPath);

validResDirName = 'val8020';
% Solves the problem of cut file names, in case the path was too long
renameCorruptedMatFiles_allSampSets(classifResPath, validResDirName);

setupSumKnnClassifRes_allTestSets_holdoutValid(classifResPath, false, validResDirName);

% Find the best model parameters according to the holdout validation (on validation set)
ROItype = 2;
setupSortResFolderTbls_Sensitivity_allSets_holdoutValid(classifResPath, ROItype, validResDirName);

% You need to save the model with the selected parameters in [path_to_selected_model]. 
% Evaluate the final model on the test set
model_path = '[path_to_selected_model]';
holdoutTestPerfRes = testHoldout_80_20_file(model_path);
