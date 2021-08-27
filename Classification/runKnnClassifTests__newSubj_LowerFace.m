% Generalization to a new subject (Rhesus)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classifName            = 'KNN_AUs_256_25616_25618i_oneSubjOut_sampSets_minLblsInTrainAndTest';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nSets = 3;  % balanced training sets

[resSaveDir, framesTblsPathList, ~, setsResSaveDirList] =...
    configureKnnClassifTests(allSubjMetaDir, imgTablesDir_LowerFace, classifName, framesTblsFileNames,...
    '', '', nSets, tblInnerName);

cvType = 'oneSubjOut';
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
    'setsResSaveDirList', 'cvType', 'isComputeEigf', 'nSets', 'isRestrictMinLblTrain', 'isRestrictMinLblTest',...
    'isSkipFullEigenfCompute', 'isSkipExplVarEigfCompute', 'isSaveMdl');

for i = 1:nSets
    runKnnClassifTests(setsResSaveDirList{i}, framesTblsPathList, imgSizePath,...
        cvType, isComputeEigf, '', [], [], [], '',...
        isSkipFullEigenfCompute, isSkipExplVarEigfCompute, isSaveMdl,...
        isRestrictMinLblTrain, isRestrictMinLblTest);
end

% Summarize the results
sumKnnClassifRes_allTestSets(setsResSaveDirList, nSets);
