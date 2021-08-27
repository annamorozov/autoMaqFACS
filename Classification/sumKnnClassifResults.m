function resTbl = sumKnnClassifResults(resDir, isGener2NewVid)

% This function is for older version of results (before traget and control classes definition)
% isGener2NewVid - optional param

filesList = dir(fullfile(resDir, '*.mat'));
resTbl = [];

if nargin < 2
    isGener2NewVid = false;
end

CVO_name = 'CVO';
classifPerf_singleTestSets_name = 'classifPerf_singleTestSets';

if isGener2NewVid
    CVO_name = 'CVO_gener2NewVid';
    classifPerf_singleTestSets_name = 'classifPerf_singleTestSets_gener2NewVid';
end

for i = 1:length(filesList)
    filename = fullfile(filesList(i).folder, filesList(i).name);
    res = load(filename);
    
    classifPerf_experTestSet = [];
    
    errorRate_ExperTest = -1;
    Sensitivity_ExperTest = -1;
    Specificity_ExperTest = -1;
    

    iExperTestSet = find(res.(CVO_name).isTestExperSubj);
    if ~isempty(iExperTestSet)
        classifPerf_experTestSet = res.(classifPerf_singleTestSets_name)(iExperTestSet); 

        errorRate_ExperTest   = classifPerf_experTestSet{:}.ErrorRate;
        Sensitivity_ExperTest = classifPerf_experTestSet{:}.Sensitivity;
        Specificity_ExperTest = classifPerf_experTestSet{:}.Specificity;
    end
    
    tgtClasses = {strjoin(res.classifPerf_CV.ClassLabels(res.classifPerf_CV.TargetClasses),',')};
    
    varNames = {'testName', 'subjNames', 'labels', 'targetClass', 'imgWidth', 'imgHeight', 'reqExplVar', ...
        'numNeighbors', 'distanceMetric', 'nTestSets',...
        'errorRate_ExperTest', 'Sensitivity_ExperTest', 'Specificity_ExperTest',...
        'errorRate_CV', 'Sensitivity_CV', 'Specificity_CV'};
    
    row = table({filesList(i).name}, {strjoin(res.subjects,',')}, {strjoin(res.labels,',')}, tgtClasses, res.imgWidth, res.imgHeight, res.reqExplVar,...
        res.numNeighbors, {res.distanceMetric}, res.(CVO_name).NumTestSets,...
        errorRate_ExperTest, Sensitivity_ExperTest, Specificity_ExperTest,...
        res.classifPerf_CV.ErrorRate, res.classifPerf_CV.Sensitivity, res.classifPerf_CV.Specificity,...
        'VariableNames', varNames);

    resTbl = [resTbl;row];
end

resTbl = sortrows(resTbl,{'Sensitivity_ExperTest'});