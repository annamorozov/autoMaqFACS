function [CVO, classifPerf_singleClasses, classifPerf_singleTestSets] =...
    crossValidate_gener2NewSubj(sourceTbl, allPredictions, experSubjName)

if nargin < 3   % experSubjName (Fascicularis)
    experSubjName = '';
end
ignoredSrcTblRows = [];
ignoredTestExperSubj = '';

if ~isempty(experSubjName)
    % Ignore the experiment subject (Fascicularis)
    iExperSubjLogic = strcmp(sourceTbl.subjName, experSubjName);
    iExperSubj = find(iExperSubjLogic);
    
    ignoredSrcTblRows    = iExperSubj;
    ignoredTestExperSubj = experSubjName;
    
    sourceTbl      = sourceTbl(~iExperSubjLogic,:);
    allPredictions = allPredictions(~iExperSubjLogic,:);
end

CVO  = {};
test = {};

relInd = find(~cellfun(@isempty,allPredictions));
relInd_sourceTbl = sourceTbl(relInd,:);
relInd_allPredictions = allPredictions(relInd);

[subjUnique, ~, iSubjUnique] = unique(relInd_sourceTbl.subjName);

numTestSets = length(subjUnique);  % The number of the subjects

% Initialize the classperformance object using the true labels
controlClasses = {'neutral_abs', 'AU_25_AU_26'};    
classifPerf_singleClasses = initClassifPerf4SpecificClasses(relInd_sourceTbl.label,...
    controlClasses);

% Here each "test set" is a different subject
classifPerf_singleTestSets = {};
for i = 1:numTestSets
    classifPerf_singleTestSets{i} = initClassifPerf4SpecificClasses(relInd_sourceTbl.label,...
        controlClasses);
end

% Initialize the classperformance object using the true labels - target
% classes are the biggest AUs
controlClasses = {'AU_1_2', 'AU_43', 'AU_25_AU_26_AU_16', 'AU_25_AU_26_AU_18i'};    
targetClasses  = {'AU_25_AU_26', 'neutral_abs'};

classifPerf_singleClasses(end+1) = initClassifPerf4SpecificClasses_ctrlCateg(relInd_sourceTbl.label,...
    controlClasses, targetClasses);

% classifPerf_singleTestSets = {};
for i = 1:numTestSets
    classifPerf_singleTestSets{i}(end+1) = initClassifPerf4SpecificClasses_ctrlCateg(relInd_sourceTbl.label,...
        controlClasses, targetClasses);
end
%%

% Select the test rows (frames): 
% every time one subject vs. all the others 
for i = 1:numTestSets
    test{i} = find(iSubjUnique == i);
end

% Update the classifier performance object with the CV results
for i=1:numTestSets
    for j = 1:length(classifPerf_singleClasses)
        classperf(classifPerf_singleClasses{j},     relInd_allPredictions(test{i}), test{i});
        classperf(classifPerf_singleTestSets{i}{j}, relInd_allPredictions(test{i}), test{i});
    end
end

CVO.NumTestSets          = numTestSets;
CVO.test                 = test;
CVO.ignoredSrcTblRows    = ignoredSrcTblRows;
CVO.ignoredTestExperSubj = ignoredTestExperSubj;
CVO.sourceTbl            = relInd_sourceTbl;
CVO.allPredictions       = relInd_allPredictions;
