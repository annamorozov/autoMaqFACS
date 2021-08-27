function [classifPerf_singleClasses, classifPerf_singleTestSets] = ...
    calculateClassifPerf_SpecificInds(GTgroup, classifPredictions, relTestLogicInd, numTestSets)

% Initialize the classperformance object using the true labels
controlClasses = {'neutral_abs', 'AU_25_AU_26'};    
classifPerf_singleClasses = initClassifPerf4SpecificClasses(GTgroup,...
    controlClasses);

% Here each "test set" is a different partition repetition
classifPerf_singleTestSets = {};
for i = 1:numTestSets
    classifPerf_singleTestSets{i} = initClassifPerf4SpecificClasses(GTgroup,...
        controlClasses);
end

% Initialize the classperformance object using the true labels - target
% classes are the biggest AUs
controlClasses = {'AU_1_2', 'AU_43', 'AU_25_AU_26_AU_16', 'AU_25_AU_26_AU_18i'};   
targetClasses  = {'AU_25_AU_26', 'neutral_abs'};

classifPerf_singleClasses(end+1) = initClassifPerf4SpecificClasses_ctrlCateg(GTgroup,...
    controlClasses, targetClasses);

for i = 1:numTestSets
    classifPerf_singleTestSets{i}(end+1) = initClassifPerf4SpecificClasses_ctrlCateg(GTgroup,...
        controlClasses, targetClasses);
end

%% Update the classifier performance object with the CV results

for i=1:numTestSets
    relTestInd = find(relTestLogicInd(:,i)); 
    
    for j = 1:length(classifPerf_singleClasses)
        classperf(classifPerf_singleClasses{j},     classifPredictions(relTestInd), relTestInd);
        classperf(classifPerf_singleTestSets{i}{j}, classifPredictions(relTestInd), relTestInd);
    end
end

