function meanImg = getSubjNeutralMeanImg(imgDirCol, imgName)
% Create neutral mean image of subject (or subjects)

sumImage = [];

fprintf('Creating subject neutral mean image...\n');

for i=1:length(imgDirCol)
    fprintf('Adding image from %s to the average...\n', imgDirCol{i});

    fullImgName = fullfile(imgDirCol{i}, imgName);
    img = imread(fullImgName);
    
    imgDouble = double(img);

    if i == 1
      sumImage = imgDouble;
    else
      sumImage = sumImage + imgDouble;
    end
end

meanImg = sumImage / length(imgDirCol);
meanImg = uint8(meanImg);