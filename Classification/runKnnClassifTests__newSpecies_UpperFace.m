% Generalization to a new subject (from Rhesus to Fascicularis)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classifName = 'KNN__AU_1_2__AU_43__neutralAbs';  
%%%%%%%%%%%%%%%%%%%%%%%%%%%
nSets = 10;

[resSaveDir, framesTblsPathList, trainOnlyInd, setsResSaveDirList] =...
    configureKnnClassifTests(allSubjMetaDir, imgTablesDir_UpperFace, classifName, framesTblsFileNames,...
    allSubjMetaDir_Exper, framesTblsFileNames_Exper, nSets);

% Build the balanced training sets
[samplesIndList, samplesIndList_global] = getRandFramesTblsSamples(framesTblsPathList(trainOnlyInd, :), nSets);

cvType = 'oneSubjOut';
isComputeEigf = false;

if ~exist(resSaveDir, 'dir')
    mkdir(resSaveDir);
end

isSkipFullEigenfCompute = false;
isSkipExplVarEigfCompute = false;

save(fullfile(resSaveDir, 'trainingParams.mat'), 'framesTblsPathList',...
    'setsResSaveDirList', 'samplesIndList', 'cvType', 'isComputeEigf', 'nSets',...
    'isSkipFullEigenfCompute', 'isSkipExplVarEigfCompute');

for i = 1:nSets
    runKnnClassifTests(setsResSaveDirList{i}, framesTblsPathList, imgSizePath,...
            cvType, isComputeEigf, experSubjName, [], samplesIndList{i}, trainOnlyInd, '',...
            isSkipFullEigenfCompute, isSkipExplVarEigfCompute);
end

% Summarize the results
sumKnnClassifRes_allTestSets(setsResSaveDirList, nSets);
