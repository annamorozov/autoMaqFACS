function ImagesAll = loadDBImgs(folderFullName)
% Load all images from databases

currentFolder = pwd;
cd(folderFullName);

% Get list of all [extension] files in this directory
pattern = sprintf('imagesDB_*.mat');
db_files = dir(pattern);
num_db = length(db_files);                           % Number of files found

if(num_db < 1)
    error('No DB found in %s!\n', folderFullName);
end

fprintf('Going to load DBs from %s...\n', folderFullName);

% Calculate dimensions for the output matrix
db_name = 'imagesDB_1.mat';                          % First DB     
load(db_name);
[m1,n1] = size(Images);                              % Images is the matrix loaded from DB
clear Images;

if(num_db == 1)                                      % If there is only one DB - take its dimensions
    m = m1;
    n = n1; 
else
    db_name = sprintf('imagesDB_%d.mat',num_db);     % Last DB
    load(db_name);
    
    m = m1;
    n = n1 * (num_db - 1) + size(Images,2);          % Last DB may have smaller size (bcause of chunks writing)
    clear Images;
end

ImagesAll = zeros(m,n);                              % Preallocate output matrix
col_indx = 0;

for i=1:num_db
    db_name = sprintf('imagesDB_%d.mat',i);
    load(db_name);
    
    [~,w] = size(Images);
    start_col = col_indx + 1;
    end_col = col_indx + w;
    ImagesAll(:,start_col:end_col) = Images;
    
    col_indx = end_col;
    clear 'Images';
    fprintf('Loaded DB %d\n',i);
end

cd (currentFolder);

fprintf('Finished loading DBs from %s\n', folderFullName);

end