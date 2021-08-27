function renameCorruptedMatFilesInDir(dirName)

files = dir(fullfile(dirName, '*'));

files = files(3:end,:);

% Loop through each
for id = 1:length(files)
    % Get the file name (minus the extension)
    [~,~,ext] = fileparts(files(id).name);

    if ~strcmp(ext, '.mat')
        filename = fullfile(files(id).folder, files(id).name);

        movefile(filename, sprintf('%s.mat', filename));
    end
end