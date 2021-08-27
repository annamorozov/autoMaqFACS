function validateHoldout_80_20_folder(resDir, validSaveDir, testLogicInd, validLogicInd,...
    nTimes, pTest, GTgroup)

fprintf('Going to validate (holdout 80/20)) dir %s...\n', resDir);

filesList = dir(fullfile(resDir, 'nPC*.mat'));

% Using one of the files in the folder, extract the experSubjInd 
% (it will be the same for the whole folder)
filename = fullfile(filesList(1).folder, filesList(1).name);
load(filename, 'CVO');

experSubjInd = CVO.test{1};

for i = 1:length(filesList)
    filename = fullfile(filesList(i).folder, filesList(i).name);
    
    validateHoldout_80_20_file(filename, validSaveDir, GTgroup, testLogicInd, validLogicInd,...
        nTimes, pTest, experSubjInd);
end
