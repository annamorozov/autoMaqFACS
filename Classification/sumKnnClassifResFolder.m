function resTbls = sumKnnClassifResFolder(resDir, sortVar, isGener2NewVid, isGener2NewSubj,...
    isSumSingleTestSets, isHoldoutValid, isF1)

% sortVar, isGener2NewVid - optional params

filesList = dir(fullfile(resDir, 'nPC*.mat'));
resTbls = {};

if nargin < 3   % isGener2NewVid
    isGener2NewVid = false;
end

if nargin < 4 % isGener2NewSubj
    isGener2NewSubj = false;
end

if nargin < 5 % isSumSingleTestSets
    isSumSingleTestSets = false;
end

if nargin < 6 % isHoldoutValid
    isHoldoutValid = false;
end

if nargin < 7 % isF1
    isF1 = false;
end

isHoldoutValidTest = false;

fprintf('Going to generate KNN result sum (new version) for dir %s...\n', resDir);

for i = 1:length(filesList)
    filename = fullfile(filesList(i).folder, filesList(i).name);
    
    if i == 1 && ~isHoldoutValid
        % Check if this is the new or the old version of results
        variableInfo = who('-file', filename);
        if ~ismember('classifPerf_singleClasses', variableInfo) % returns true
            fprintf('classifPerf_singleClasses doesnt exist.\n Going to generate old vesion res sum...\n');
            sumKnnClassifResults(resDir);   % old version
            break;
        end
    end
    
    % Here the resTblRows is resTblRows_singleClasses
    % (and not resTblRows_singleTestSets)
    resTblRows = sumKnnClassifResFile(filename, isGener2NewVid, isGener2NewSubj,...
        isSumSingleTestSets, isHoldoutValid, isHoldoutValidTest, isF1);    % new version
    
    if i == 1
        resTbls = cell(size(resTblRows));
    end
    
    for j=1:numel(resTblRows)
        resTbls{j} = [resTbls{j}; resTblRows{j}];   
    end
end

if nargin < 2 || isempty(sortVar)  % sortVar
    if isF1
        if any(strcmp('f1_ExperTest',resTbls{1}.Properties.VariableNames))
            sortVar = {'f1_ExperTest'};
        else
            sortVar = {'f1_CV'};
        end
    else
        if any(strcmp('Sensitivity_ExperTest',resTbls{1}.Properties.VariableNames)) && ...
                any(strcmp('Specificity_ExperTest',resTbls{1}.Properties.VariableNames))
            sortVar = {'Sensitivity_ExperTest','Specificity_ExperTest'};
        else
            sortVar = {'Sensitivity_CV','Specificity_CV'};
        end
    end
end

for i=1:numel(resTbls)
    if ~isempty(resTbls{i})
        resTbls{i} = sortrows(resTbls{i}, sortVar, 'descend');
    end
end