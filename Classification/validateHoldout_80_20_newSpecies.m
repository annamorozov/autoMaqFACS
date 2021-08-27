function validateHoldout_80_20_newSpecies(classifResPath)

pTest = 0.2;
nTimes = 100;

subfoldersPaths = getAllSubfolders(classifResPath);

len = length(subfoldersPaths);

% Extact the experiment subject ground truth (GT) labels from the first file of the first
% folder - they are going to be the same in all the sample sets.
filesList = dir(fullfile(subfoldersPaths{1}, 'nPC*.mat'));

% Using one of the files in the folder, extract the experSubjInd 
% (it will be the same for the whole folder)
filename = fullfile(filesList(1).folder, filesList(1).name);
load(filename, 'CVO');

experSubjInd = CVO.test{1};
GTgroup = CVO.groundTruth(experSubjInd);    
[testLogicInd, validLogicInd] = getValidAndTestPartition(GTgroup, pTest, nTimes);

save(fullfile(classifResPath, 'validationDetails.mat'), 'GTgroup', 'testLogicInd', 'validLogicInd');

for i = 1:len
    validSaveDir = fullfile(subfoldersPaths{i}, 'validation_80_20');
    if ~exist(validSaveDir, 'dir')
       mkdir(validSaveDir)
    end
    
    validateHoldout_80_20_folder(subfoldersPaths{i}, validSaveDir, testLogicInd, validLogicInd,...
        nTimes, pTest, GTgroup);
end



