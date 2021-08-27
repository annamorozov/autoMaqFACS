function classifPerf_singleClasses = initClassifPerf4SpecificClasses_ctrlCateg(GT, controlClasses, targetClasses)

% The function creates CP objects where the control classes are as
% specified in [controlClasses], and the target classes are the ones that
% are not in [controlClasses], each class separately.

% targetClasses - optional param, specifies the target (positive classes)

% GT = Ground Truth
% controlClasses - list of control classes ('Negative')

% ("Logic" = logical)

if nargin < 3   % targetClasses
    targetClasses = {};
end
    

classifPerf_singleClasses = {};

classes = unique(GT);
ctrlClassLogic = ismember(classes, controlClasses);

if any(ctrlClassLogic)
    controlClasses = classes(ctrlClassLogic);
    
    if isempty(targetClasses)
        targetClasses  = classes(~ctrlClassLogic);
    else
        tgtClassLogic = ismember(classes, targetClasses);
        if any(tgtClassLogic)
            targetClasses = classes(tgtClassLogic);
        else
            % No tgt classes
            classifPerf_singleClasses{1} = classperf(GT);
        end
    end

    for i = 1:length(targetClasses)
        classifPerf_singleClasses{i} = classperf(GT, 'Positive', targetClasses{i},...
            'Negative', controlClasses);
    end
    lastInd = i;
else
    classifPerf_singleClasses{1} = classperf(GT);
end
