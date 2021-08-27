function [padRows, padCols] = getImgPad2FitDatasetSize(nImgRows, nImgCols, datasetOutputView)

% Resize params

padRows = (datasetOutputView.ImageSize(2) - nImgRows)/2;
padCols = (datasetOutputView.ImageSize(1) - nImgCols)/2;
