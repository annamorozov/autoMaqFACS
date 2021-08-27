function [allSetsTbl_Sensitivity, allSetsTbl_Sensitivity_full] =...
    sortResFolderTbls_Sensitivity_allSets(classifResPath, ROItype, isGener2NewVid,...
    isCVresCol, isGener2NewSubj, isHoldoutValid, isHoldoutValid_Peaks, validDirName)

% Generate the name of the relevant result, summarize and sort its
% perfromance.

% ROItype    - 1 = upper face, 2 = lower face

% isGener2NewVid, isCVresCol - optional params
% isCVresCol - optional param: are the results for computation should be
%              taken from _CV columns (if true) or from _ExperTest (if false)

allSetsTbl_Sensitivity = [];
allSetsTbl_Sensitivity_full = [];

subfoldersPaths = getAllSubfolders(classifResPath);

if nargin < 3   % isGener2NewVid
    isGener2NewVid = false;
end
if nargin < 4   % isCVresCol
    isCVresCol = false;
end
if nargin < 5   % isGener2NewSubj
    isGener2NewSubj = false;
end
if nargin < 6   % isHoldoutValid
    isHoldoutValid = false;
end
if nargin < 7   % isHoldoutValid_Peaks
    isHoldoutValid_Peaks = false;
end
if nargin < 8   % validDirName
    validDirName = 'validation_80_20';
end

fldrTblsResName = 'sumKnnClassifResultsFolderTbls.mat';
setSensitivityResName = 'sumKnnClassifResultsFolderTbls_Sensitivity.mat';

% Gener to new subj, new (one) vid
if isGener2NewVid
    fldrTblsResName = 'sumKnnClassifResultsFolderTbls_gener2NewVid.mat';
    setSensitivityResName = 'sumKnnClassifResultsFolderTbls_gener2NewVid_Sensitivity.mat';
    isCVresCol = true;
end

% Eiher same subj gener to new vid, or gener to new subj, all vids
if ~isGener2NewVid && isCVresCol
    fldrTblsResName = 'sumKnnClassifResultsFolderTbls.mat';
    setSensitivityResName = 'sumKnnClassifResultsFolderTbls_Sensitivity_fromCVcol.mat';
end

% Gener to new subj (not video)
if isGener2NewSubj
    fldrTblsResName = 'sumKnnClassifResultsFolderTbls_gener2NewSubj.mat';
    setSensitivityResName = 'sumKnnClassifResultsFolderTbls_gener2NewSubj_Sensitivity.mat';
    isCVresCol = true;
end

if ROItype == 1 % upper
    sensName1 = 'AU1_2_sens';
    sensName2 = 'AU43_sens';
    sensName3 = 'Neutral_sens';
elseif ROItype == 2 % lower
    sensName1 = 'AU256_16_sens';
    sensName2 = 'AU256_18i_sens';
    sensName3 = 'AU256_sens';
else
    error('ROItype must be either 1 or 2!');
end

for i = 1:length(subfoldersPaths)
    [~,fldr,~] = fileparts(subfoldersPaths{i});
    if ~strncmpi(fldr, 'sampSet', 7)
        subfoldersPaths(i) = [];
        break;
    end
end

for i = 1:length(subfoldersPaths)
    [~,setName,~] = fileparts(subfoldersPaths{i});
    
    resFolder = subfoldersPaths{i};
    
    if isHoldoutValid
        resFolder = strcat(resFolder, sprintf('\\%s', validDirName));
    elseif isHoldoutValid_Peaks
        resFolder = strcat(resFolder, '\validPks');
    end
    
    if ~exist(resFolder, 'dir')
        fprintf('sortResFolderTbls_Sensitivity_allSets: dir %s doesnt exist...\n', resFolder);
        continue;
    end
    
    
    resFileName = fullfile(resFolder, fldrTblsResName);
    load(resFileName);
    
    [resFolderTbls_Sensitivity, best3Rows] = sortResFolderTbls_Sensitivity_oneSet(resFolderTbls,...
        ROItype, isCVresCol, isHoldoutValid_Peaks);
    save(fullfile(resFolder, setSensitivityResName), 'resFolderTbls_Sensitivity');
    
    bestLim = height(best3Rows);
    setNameCol = {};
    [setNameCol{1:bestLim}] = deal(setName);
    thisTbl = table(setNameCol', best3Rows.testName, best3Rows.errorRate,...
        best3Rows.(sensName1), best3Rows.(sensName2), best3Rows.(sensName3), best3Rows.sensAvg,...
        'VariableNames', {'setName', 'testName', 'errorRate', sensName1, sensName2, sensName3, 'sensAvg'});
    
    [setNameCol{1:height(resFolderTbls_Sensitivity)}] = deal(setName);
    thisTbl_full = table(setNameCol', resFolderTbls_Sensitivity.testName, resFolderTbls_Sensitivity.errorRate,...
        resFolderTbls_Sensitivity.(sensName1), resFolderTbls_Sensitivity.(sensName2),...
        resFolderTbls_Sensitivity.(sensName3), resFolderTbls_Sensitivity.sensAvg,...
        'VariableNames', {'setName', 'testName', 'errorRate', sensName1, sensName2, sensName3, 'sensAvg'});
    
    allSetsTbl_Sensitivity = [allSetsTbl_Sensitivity; thisTbl];
    allSetsTbl_Sensitivity_full = [allSetsTbl_Sensitivity_full; thisTbl_full];
end

allSetsTbl_Sensitivity = sortrows(allSetsTbl_Sensitivity, {'sensAvg'}, 'descend');
allSetsTbl_Sensitivity_full = sortrows(allSetsTbl_Sensitivity_full, {'sensAvg'}, 'descend');



    


