function loadedVar = loadAndRenameVar(path, varName)

% varName - optional param

    if nargin > 1   % varName
        origVarName = varName;
    else
        [~, origVarName, ~] = fileparts(path);
    end
    
    loadedVar = load(path,origVarName);  % Function output form of LOAD
    loadedVar = loadedVar.(origVarName);
end