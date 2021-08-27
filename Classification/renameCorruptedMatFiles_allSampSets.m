function renameCorruptedMatFiles_allSampSets(classifResPath, validResDirName)
% Solves the problem of cut file names, in case the path was too long

load(fullfile(classifResPath, 'trainingParams.mat'), 'setsResSaveDirList', 'nSets');

if nargin < 2   % validResDirName
    validResDirName = 'validation_80_20';
end

setsResSaveDirList = strcat(setsResSaveDirList, sprintf('\\%s',validResDirName));

for i = 1:nSets
    renameCorruptedMatFilesInDir(setsResSaveDirList{i});
end
