function holdoutTestPerfRes = testHoldout_80_20_file(classifPerfFilePath, isTestAllSampSets, isF1)

% classifPerfPath - file path under 'validation_80_20' folder (full path)

if nargin < 2   % isTestAllSampSets
    isTestAllSampSets = false;
end

if nargin < 3   % isF1
    isF1 = false;
end

load(classifPerfFilePath);

[holdoutDir,name,ext] = fileparts(classifPerfFilePath);
[sampSetDir, ~, ~] = fileparts(holdoutDir);

fullClassifPerf_path = fullfile(sampSetDir,sprintf('%s%s', name, ext));
load(fullClassifPerf_path, 'CVO');

% Experiment subject test set
classifPredictions = CVO.classifPredictions{1};

GTgroup = cp.CVO.GTgroup;
testLogicInd = cp.CVO.testLogicInd;
nTimes = cp.CVO.NumTestSets;

[classifPerf_singleClasses, classifPerf_singleTestSets] = ...
    calculateClassifPerf_SpecificInds(GTgroup, classifPredictions, testLogicInd, nTimes);

holdoutTestPerfRes.CVO = cp.CVO;
holdoutTestPerfRes.classifPerf_singleClasses_Test = classifPerf_singleClasses;
holdoutTestPerfRes.classifPerf_singleTestSets_Test = classifPerf_singleTestSets;
holdoutTestPerfRes.bestClassifPath = classifPerfFilePath;

fileSaveName = 'holdoutTestPerfRes';

if isTestAllSampSets
    if isF1
        fileSaveName = 'holdoutTestPerfRes_forF1_avg';
    end

    save(fullfile(holdoutDir, sprintf('%s.mat', fileSaveName)), 'holdoutTestPerfRes');
else
    if isF1
        fileSaveName = 'holdoutTestPerfRes_forF1_best';
    end
    
    [classifDir, ~, ~] = fileparts(sampSetDir);
    save(fullfile(classifDir, sprintf('%s.mat', fileSaveName)), 'holdoutTestPerfRes');
    save(fullfile(holdoutDir, sprintf('%s.mat', fileSaveName)), 'holdoutTestPerfRes');
end

