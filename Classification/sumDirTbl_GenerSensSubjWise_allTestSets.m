function sumDirTbl_GenerSensSubjWise_allTestSets(setsResSaveDirList, nSets, ROItype, isGenerateNewCVpart)

if nargin < 4
    isGenerateNewCVpart = false; 
end

isSave2cpFile = true;

for i = 1:nSets
    sumDirTbl_GenerSensSubjWise =...
        sumKnnClassifResFolder_GenerSensSubjWise(setsResSaveDirList{i}, ROItype, isSave2cpFile, isGenerateNewCVpart);
    
    resFileName = fullfile(setsResSaveDirList{i}, 'sumDirTbl_GenerSensSubjWise.mat');
    save(resFileName, 'sumDirTbl_GenerSensSubjWise');
end