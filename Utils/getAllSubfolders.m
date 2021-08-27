function [subfoldersPaths, nameFolds] = getAllSubfolders(folderPath, startStr)

% startStr - optional param. Get only subdirs with names starting with [startStr].

d = dir(folderPath);

if nargin > 1 % startStr
    d = dir(fullfile(folderPath, sprintf('%s*', startStr)));
end

isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

subfoldersPaths = fullfile(folderPath, nameFolds);
