function fullSetupAllSubjInitializePath(rawDataMainDir, procDataMainDir, subjNames, vidExten, vidPrefix2Del)
% Initialize paths for data processing of all subjects
% vidPrefix2Del - optional param

for i = 1:length(subjNames)
    rawDataDir = fullfile(rawDataMainDir, subjNames{i});
    procDataDir = fullfile(procDataMainDir, subjNames{i});

    % Initialize path
    if nargin > 4   % vidPrefix2Del
        [pathTbl, wholeSubjPath] = setupInitializePath(rawDataDir, procDataDir,...
            subjNames{i}, vidExten, vidPrefix2Del);
    else
        [pathTbl, wholeSubjPath] = setupInitializePath(rawDataDir, procDataDir,...
            subjNames{i}, vidExten);
    end
    
    if ~exist(procDataDir, 'dir')
        mkdir(procDataDir);
    end
    
    save(fullfile(procDataDir, 'pathTbl.mat'), 'pathTbl');
    save(fullfile(procDataDir, 'wholeSubjPath.mat'), 'wholeSubjPath');
end