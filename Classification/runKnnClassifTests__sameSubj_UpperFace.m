% Generalization to the same subject (Rhesus)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classifName            = 'KNN__AU_1_2__AU_43__neutralAbs__sameSubjOneVidOut__sampSets_minLblsTrainTest';  
%%%%%%%%%%%%%%%%%%%%%%%%%%%
nSets = 3;  % balanced training sets

[resSaveDir, framesTblsPathList, ~, setsResSaveDirList] =...
    configureKnnClassifTests(allSubjMetaDir, imgTablesDir_UpperFace, classifName, framesTblsFileNames,...
    '', '', nSets);

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

save(fullfile(resSaveDir, 'trainingParams.mat'), 'framesTblsPathList',...
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







