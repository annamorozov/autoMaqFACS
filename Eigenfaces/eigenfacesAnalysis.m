function [weights, meanImgVec, eigVectors, nPCs, kneeExplVar] = eigenfacesAnalysis(imgWidth, imgHeight, rawFeatures,...
    isShow, saveDir, isCloseFigs, requestedExplVar)


%% Setup
nImgs = size(rawFeatures, 2);      % features/training images number
nImgPixs = size(rawFeatures, 1);      % dimensions in each feature (vector)

% Tolerance to corr.
epsilon = 0.00001;
nPCs2Display = 10;

fprintf('EigenfacesAnalysis: going to start the analysis...\n'); 

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

kneeExplVar = 0;

if requestedExplVar ~= 0   % requestedExplVar
    [nPCs, ~, ~]           = getPCsExplainedVariance(eigValues, nImgs, isShow, requestedExplVar);
else            % "knee"
    [~, nPCs, kneeExplVar] = getPCsExplainedVariance(eigValues, nImgs, isShow);
end

% Normalize eigVectors to unit length, kill vectors corr. to tiny evalues
[eigVectors, ~] = normalizeAndFilterEigVecs(eigVectors, eigValues, nImgs, nPCs, epsilon);
% Here we have vectors normalized to unit length.
% The range changes [-1,1].

%% Weights

% Find out weights for all eigenfaces
% Each column contains weight for corresponding image
W_train = eigVectors'*variancesMat;

%% Display PCA patches

% 'imadjust':
% Adjust the contrast of the image so that 1% of the data is saturated 
% at low and high intensities.
% Looks pretty similar on original and scaled(x4)
% Catches a lot of little detailes.
% A lot of values are mapped to white (1).

if isShow
    displayPCAPatches(eigVectors, nPCs2Display, nPCs, imgWidth, imgHeight, 'imadjust');
end

%% Eigenface coding
weights = W_train';

if isShow
    % means of each column (each column - weights of single PC in all images)
    % [1 x nPCs] vector
    meanWeights = mean(weights, 1); 

    % standard deviation of each column
    % [1 x nPCs] vector
    stdWeights = std(weights);

    % Adding mean PCs to the mean img and varying SD:
    sdNum = 3;
    pcNum = 5;
    isNormalize = false;

    showPCsSD(sdNum, pcNum, eigVectors, meanWeights, stdWeights, meanImgVec, imgWidth, imgHeight, isNormalize);
end

%% Save
if ~isempty(saveDir)
    saveAllFigures(saveDir);
    
    allVarsSavePath = sprintf('%s/eigfacesData',saveDir);
    save(allVarsSavePath, 'meanImgVec', 'epsilon', 'eigVectors', 'eigValues',...
        'nPCs', 'weights', 'kneeExplVar');
    
    fprintf('EigenfacesAnalysis: finished to make analysisand saving to %s.\n', saveDir); 
else
    fprintf('EigenfacesAnalysis: finished to make the analysis.\n'); 
end

if isCloseFigs
    close all; 
end

%% [frameNum] feature reconstruction 
%frameNum = 16330;
%reconstFrame = reconstructFeatureFromEigv(weights(frameNum,:), eigVectors, meanImgVec, imgWidth, imgHeight);
