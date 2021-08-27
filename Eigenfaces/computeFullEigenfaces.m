function [meanImgVec, eigVectors, eigValues, nImgs, variancesMat] = computeFullEigenfaces(imgWidth, imgHeight, rawFeatures,...
    isShow, saveDir)

% Compute the full eigenfaces

%% Setup
nImgs = size(rawFeatures, 2);      % features/training images number
nImgPixs = size(rawFeatures, 1);      % dimensions in each feature (vector)

fprintf('computeFullEigenfaces: going to start the computation...\n'); 

%% Find Psi (meanImgVec) - the mean feature

% Mean calculation is per each image. This is the mean image.
% The pixel values are 0-255
meanImgVec = mean(rawFeatures, 2); 

% Show mean feature
reshapeAndShowImg(meanImgVec, imgWidth, imgHeight, 'the mean feature', isShow);
%normAndShowImg(meanImgVec, imgWidth, imgHeight, 'the mean feature normalized');

%% Find Phi (variancesMat) - the variances

% Phi - modified representation of training images.
% Phi is the matrix of: [features_mat] - mean_vec
% for each img:
for i = 1:nImgs
    variancesMat(:,i) = rawFeatures(:,i) - meanImgVec;
end
% Phi is the first instance to have negative values.
% The range changes to [-255,255].

%% Find the eigenvectors

% Create a matrix from all modified vector images
% variancesMat is the variances matrix [nImgPixs x nImgs]

% Find covariance matrix using the trick
% size(covMat) = [nImgs x nImgs]
covMat = variancesMat'*variancesMat; 

% Get the eigenvectors (columns of [eigVectors]) and eigenvalues (diag of [eigValues])
% eigVectors and eigValues are [nImgs x nImgs]
fprintf(1,'Calculating eigenvectors...\n');

[eigVectors,eigValues] = eig(covMat);

fprintf(1,'Eigenvectors successfully calculated.\n');

% Sort the vectors/values according to size of eigenvalue
% Decsending sort
[eigVectors,eigValues] = sortEigenVecs(eigVectors,eigValues);

% Convert the eigenvectors of variancesMat'*variancesMat into eigenvectors of variancesMat*variancesMat'
% Here the eigVectors will be [nImgPixs x nImgs]
fprintf(1,'Computing eigenvectors of the real covariance matrix...\n');
eigVectors = variancesMat*eigVectors;
fprintf(1,'Eigenvectors of covariance matrix computed.\n');

% Get the eigenvalues out of the diagonal matrix and
% normalize them so the evalues are specifically for cov(A'), not A*A'.
eigValues = diag(eigValues);
eigValues = eigValues / (nImgs-1);

%% Save
if ~isempty(saveDir)    
    fullEigfSavePath = fullfile(saveDir, 'fullEigenfaces');
    save(fullEigfSavePath, 'meanImgVec', 'eigVectors', 'eigValues');
    
    fprintf('computeFullEigenfaces: finished to compute full eigenfaces and saving to %s.\n', fullEigfSavePath); 
else
    fprintf('computeFullEigenfaces: finished to compute full eigenfaces.\n'); 
end
