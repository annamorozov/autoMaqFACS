function [resSaveDir, framesTblsPathList, trainOnlyInd, setsResSaveDirList] = configureKnnClassifTests(...
    allSubjMetaDir, imgTablesDirName, classifName, framesTblsFileNames,...
    allSubjMetaDir_Exper, framesTblsFileNames_Exper, nSets, tblInnerName)

% Configure the KNN classification parameters    

% Optional params:
% allSubjMetaDir_Exper, framesTblsFileNames_Exper - in case of generalization to another species
% nSets - number of balanced training sets 

fprintf('Going to configure KNN classification tests for %s...\n', classifName);

imgTablesDir = fullfile(allSubjMetaDir, imgTablesDirName);
resSaveDir   = fullfile(imgTablesDir,   classifName);

setsResSaveDirList = {};
if nargin > 6   % nSets
    for i=1:nSets
        setsResSaveDirList{i} = fullfile(resSaveDir, sprintf('sampSet_%d', i));
    end
end

framesTblsPathList           = fullfile(imgTablesDir, framesTblsFileNames(:));
trainOnlyInd                 = 1:length(framesTblsPathList);

if nargin > 5 && ~isempty(allSubjMetaDir_Exper) && ~isempty(framesTblsFileNames_Exper)  % allSubjMetaDir_Exper, framesTblsFileNames_Exper
    imgTablesDir_Exper       = fullfile(allSubjMetaDir_Exper, imgTablesDirName);
    framesTblsPathList_Exper = fullfile(imgTablesDir_Exper,   framesTblsFileNames_Exper(:));

    framesTblsPathList = [framesTblsPathList; framesTblsPathList_Exper];
end

if nargin > 7   % tblInnerName
    [innerNamesCol{1:length(framesTblsPathList),1}] = deal(tblInnerName); 
    framesTblsPathList = [framesTblsPathList innerNamesCol];
end

fprintf('Finished the KNN tests configuration.\n');


