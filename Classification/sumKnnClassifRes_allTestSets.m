function sumKnnClassifRes_allTestSets(setsResSaveDirList, nSets, sortVar,...
    isGener2NewVid, isGener2NewSubj, isSumSingleTestSets, isHoldoutValid, isF1)

if nargin < 3   % sortVar
    sortVar = '';
end

if nargin < 4   % isGener2NewVid
    isGener2NewVid = false;
end

if nargin < 5 % isGener2NewSubj
    isGener2NewSubj = false;
end

if nargin < 6 % isSumSingleTestSets
    isSumSingleTestSets = false;
end

if nargin < 7 % isHoldoutValid
    isHoldoutValid = false;
end

if nargin < 8 % isF1
    isF1 = false;
end

for i = 1:nSets
    resFolderTbls = sumKnnClassifResFolder(setsResSaveDirList{i}, sortVar,...
        isGener2NewVid, isGener2NewSubj, isSumSingleTestSets, isHoldoutValid, isF1);
    
    if isF1
        resFileName = fullfile(setsResSaveDirList{i}, 'sumKnnClassifResultsFolderTbls_F1.mat');
        save(resFileName, 'resFolderTbls');        
    else
        resFileName = fullfile(setsResSaveDirList{i}, 'sumKnnClassifResultsFolderTbls.mat');
        save(resFileName, 'resFolderTbls');
    end
end
