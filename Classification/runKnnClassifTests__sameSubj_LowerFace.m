% Generalization to the same subject (Rhesus)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classifName            = 'KNN__AUs_256_25616_25618i__sameSubjOneVidOut__sampSets__minLblOnTrainTest';  
%%%%%%%%%%%%%%%%%%%%%%%%%%%

nSets = 3;

[resSaveDir, framesTblsPathList, ~, setsResSaveDirList] =...
    configureKnnClassifTests(allSubjMetaDir, imgTablesDir_LowerFace, classifName, framesTblsFileNames,...
    '', '', nSets, tblInnerName);

cvType = 'sameSubjOneVidOut';   % cross-validation type
isComputeEigf = false; 
isRestrictMinLblTrain = true;
isRestrictMinLblTest = true;
isSkipFullEigenfCompute = false;
isSkipExplVarEigfCompute = false;
isSaveMdl = false;

if ~exist(resSaveDir, 'dir')
    mkdir(resSaveDir);
end

save(fullfile(resSaveDir, 'trainingParams.mat'), 'framesTblsPathList', 'tblInnerName',...
    'setsResSaveDirList', 'cvType', 'isComputeEigf', 'nSets',... 
    'isRestrictMinLblTrain', 'isRestrictMinLblTest',...
    'isSkipFullEigenfCompute', 'isSkipExplVarEigfCompute', 'isSaveMdl');

for i = 1:nSets
    runKnnClassifTests(setsResSaveDirList{i}, framesTblsPathList, imgSizePath,...
        cvType, isComputeEigf, '', [], [], [], '',...
        isSkipFullEigenfCompute, isSkipExplVarEigfCompute, isSaveMdl,... 
        isRestrictMinLblTrain, isRestrictMinLblTest);
end

% Summarize the results
sumKnnClassifRes_allTestSets(setsResSaveDirList, nSets);

