function classifPerf_singleClasses = initClassifPerf4SpecificClasses(GT, controlClasses)

% The function creates CP objects where the control classes are as
% specified in [controlClasses], and the target classes are the ones that
% are not in [controlClasses], each class separately.

% GT = Ground Truth
% controlClasses - list of control classes ('Negative')

% ("Logic" = logical)

classifPerf_singleClasses = {};

classes = unique(GT);
ctrlClassLogic = ismember(classes, controlClasses);

if any(ctrlClassLogic)
    controlClasses = classes(ctrlClassLogic);
    targetClasses  = classes(~ctrlClassLogic);

    % one (target) vs one (control)
    for i = 1:length(targetClasses)
        classifPerf_singleClasses{i} = classperf(GT, 'Positive', targetClasses{i},...
            'Negative', controlClasses);
    end
    lastInd = i;
    
    % one (target) vs many (control and targets)
    for i = 1:length(targetClasses)
        classifPerf_singleClasses{lastInd+i} = classperf(GT, 'Positive', targetClasses{i},...
            'Negative', [controlClasses, targetClasses{(1:length(targetClasses))~=i}]);
    end
else
    classifPerf_singleClasses{1} = classperf(GT);
end
