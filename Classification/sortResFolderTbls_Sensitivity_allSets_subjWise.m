function allSetsTbl_Sensitivity_full_subjWise = sortResFolderTbls_Sensitivity_allSets_subjWise(classifResPath)

allSetsTbl_Sensitivity_full_subjWise = [];

subfoldersPaths = getAllSubfolders(classifResPath);

setSensitivityResName = 'sumDirTbl_GenerSensSubjWise.mat';

for i = 1:length(subfoldersPaths)
    [~,setName,~] = fileparts(subfoldersPaths{i});
    
    resFileName = fullfile(subfoldersPaths{i}, setSensitivityResName);
    load(resFileName);

    setNameCol = {};
    [setNameCol{1:height(sumDirTbl_GenerSensSubjWise)}] = deal(setName);

    sumDirTbl_GenerSensSubjWise.setName = setNameCol';
    allSetsTbl_Sensitivity_full_subjWise = [allSetsTbl_Sensitivity_full_subjWise; sumDirTbl_GenerSensSubjWise];
end

allSetsTbl_Sensitivity_full_subjWise = sortrows(allSetsTbl_Sensitivity_full_subjWise, {'nanmean_sensAvg'}, 'descend');

save(fullfile(classifResPath,'allSetsTbl_Sensitivity_full_subjWise.mat'),'allSetsTbl_Sensitivity_full_subjWise');



    


