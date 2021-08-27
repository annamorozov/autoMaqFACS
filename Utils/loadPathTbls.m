function [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjName)
    procDataDir = fullfile(procDataDir_allSubj, subjName);
    
    load(fullfile(procDataDir, 'pathTbl.mat'), 'pathTbl');
    load(fullfile(procDataDir, 'wholeSubjPath.mat'), 'wholeSubjPath');
end