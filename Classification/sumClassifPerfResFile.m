function [resSum_singleClasses, resSum_singleTestSets] = sumClassifPerfResFile(...
    filename, isGener2NewVid, isGener2NewSubj, isSumSingleTestSets,...
    isHoldoutValid, isHoldoutValidTest, isF1, isSumSingleTestSetsOnly)

%Important: this only works when in each clasifPerf there is only one target
%           class.

% Result: res struct for each target class (the structs are in a cell
% array).
% The cell index of each target class is the target class index.

% isGener2NewVid - optional param

res = load(filename);

resSum_singleClasses = {};
resSum_singleTestSets = {};

if nargin < 2 % isGener2NewVid
    isGener2NewVid = false;
end
if nargin < 3 % isGener2NewSubj
    isGener2NewSubj = false;
end

if nargin < 4 % isSumSingleTestSets
    isSumSingleTestSets = false;
end

if nargin < 5   % isHoldoutValid
    isHoldoutValid = false; 
end

if nargin < 6   % isHoldoutValidTest
    isHoldoutValidTest = false; 
end

if nargin < 7   % isF1
    isF1 = false; 
end

if nargin < 8   % isSumSingleTestSetsOnly
    isSumSingleTestSetsOnly = false; 
end

classifPerf_singleClasses_name  = 'classifPerf_singleClasses';
classifPerf_singleTestSets_name = 'classifPerf_singleTestSets';
CVO_name = 'CVO';
    
if isGener2NewVid
    classifPerf_singleClasses_name  = 'classifPerf_singleClasses_gener2NewVid';
    classifPerf_singleTestSets_name = 'classifPerf_singleTestSets_gener2NewVid';
    CVO_name = 'CVO_gener2NewVid';
elseif isGener2NewSubj
    classifPerf_singleClasses_name  = 'classifPerf_singleClasses_gener2NewSubj';
    classifPerf_singleTestSets_name = 'classifPerf_singleTestSets_gener2NewSubj';
    CVO_name = 'CVO_gener2NewSubj';
elseif isHoldoutValid
    classifPerf_singleClasses_name  = 'classifPerf_singleClasses_Valid';
    classifPerf_singleTestSets_name = 'classifPerf_singleTestSets_Valid';
    
    res = res.cp;
elseif isHoldoutValidTest
    classifPerf_singleClasses_name  = 'classifPerf_singleClasses_Test';
    classifPerf_singleTestSets_name = 'classifPerf_singleTestSets_Test';
    
    res = res.holdoutTestPerfRes;
end

% Different single classes
if ~isSumSingleTestSetsOnly
    for j=1:length(res.(classifPerf_singleClasses_name))
        cpSingleClass = res.(classifPerf_singleClasses_name){j};
        tgtClassInd = cpSingleClass.TargetClasses;

        if isF1
            sumSingleClass = sumClassifPerf4SpecificClass_f1(cpSingleClass);
        else
            sumSingleClass = sumClassifPerf4SpecificClass(cpSingleClass);
        end

        resSum_singleClasses{tgtClassInd}.tgtClassInd    = tgtClassInd;
        resSum_singleClasses{tgtClassInd}.tgtClass       = cpSingleClass.ClassLabels{tgtClassInd};

        if ~isfield(resSum_singleClasses{tgtClassInd}, 'sumSingleClass')
            resSum_singleClasses{tgtClassInd}.sumSingleClass = {};
        end
        resSum_singleClasses{tgtClassInd}.sumSingleClass{end+1} = sumSingleClass;
    end

    % Experiment test set
    if isfield(res.(CVO_name),'isTestExperSubj') && ~isempty(find(res.(CVO_name).isTestExperSubj))
        iExperTestSet = find(res.(CVO_name).isTestExperSubj);
        classifPerf_experTestSet = res.(classifPerf_singleTestSets_name){iExperTestSet};

        % Different single classes
        for j=1:length(classifPerf_experTestSet)
            cpSingleClass_experSet = classifPerf_experTestSet{j};
            tgtClassInd = cpSingleClass_experSet.TargetClasses;

            if isF1
                sumSingleClass_experSet = sumClassifPerf4SpecificClass_f1(cpSingleClass_experSet);
            else
                sumSingleClass_experSet = sumClassifPerf4SpecificClass(cpSingleClass_experSet);
            end

            if ~isfield(resSum_singleClasses{tgtClassInd}, 'sumSingleClass_experSet')
                resSum_singleClasses{tgtClassInd}.sumSingleClass_experSet = {};
            end

            resSum_singleClasses{tgtClassInd}.sumSingleClass_experSet{end+1} = sumSingleClass_experSet; 
        end
    else
        resSum_singleClasses{tgtClassInd}.sumSingleClass_experSet = [];
    end
end

if isSumSingleTestSets
    % Different single test sets
    for i=1:length(res.(classifPerf_singleTestSets_name))

        cpSingleTestSet = res.(classifPerf_singleTestSets_name){i};

        for j=1:length(cpSingleTestSet)
            cpSingleClass = cpSingleTestSet{j}; 

            tgtClassInd = cpSingleClass.TargetClasses;

            if isF1
                sumSingleClass = sumClassifPerf4SpecificClass_f1(cpSingleClass);
            else
                sumSingleClass = sumClassifPerf4SpecificClass(cpSingleClass);
            end

            resSum_singleTestSets{i}{tgtClassInd}.tgtClassInd    = tgtClassInd;
            resSum_singleTestSets{i}{tgtClassInd}.tgtClass       = cpSingleClass.ClassLabels{tgtClassInd};

            if ~isfield(resSum_singleTestSets{i}{tgtClassInd}, 'sumSingleClass')
                resSum_singleTestSets{i}{tgtClassInd}.sumSingleClass = {};
            end
            resSum_singleTestSets{i}{tgtClassInd}.sumSingleClass{end+1} = sumSingleClass;
        end
    end
end