function setupConvertVid2DB(vidFileCol, DBDirCol, scaleF)
% Convert video files to databases

if length(vidFileCol) ~= length(DBDirCol)
    error('Not matching heights of vidFileCol and DBDirCol. First row: %s', vidFileCol{1});
end

for i = 1:length(vidFileCol)
    if nargin > 2   % scaleF
        convertVid2DB(vidFileCol{i}, DBDirCol{i},...
            'imgBuffer', 500, 'scale', scaleF);
    else
        convertVid2DB(vidFileCol{i}, DBDirCol{i},...
            'imgBuffer', 500);
    end
end

  