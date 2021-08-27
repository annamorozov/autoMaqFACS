function validateHoldout_80_20_file(filename, validSaveDir, GTgroup, testLogicInd, validLogicInd,...
    nTimes, pTest, experSubjInd)

load(filename, 'CVO');

cp = perform_80_20_Validation(CVO, GTgroup, validLogicInd, testLogicInd,...
    nTimes, pTest, experSubjInd);

[~,name,~] = fileparts(filename);
save(fullfile(validSaveDir, name), 'cp');