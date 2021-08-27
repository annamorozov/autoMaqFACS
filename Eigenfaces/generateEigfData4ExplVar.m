function [weights, eigVectors, nPCs, kneeExplVar] = generateEigfData4ExplVar(eigVectors, eigValues, nImgs, requestedExplVar, variancesMat,...
    imgWidth, imgHeight, isShow, figsSaveDir, isCloseFigs, meanImgVec)

% Generate eigenfaces data for requested explained variance, perform some
% analysis and save figures

kneeExplVar = 0;

% Tolerance to corr.
epsilon = 0.00001;
nPCs2Display = 10;


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
if ~isempty(figsSaveDir)
    saveAllFigures(figsSaveDir);
    
    fprintf('EigenfacesAnalysis: finished to make analysis and saving to %s.\n', figsSaveDir); 
else
    fprintf('EigenfacesAnalysis: finished to make the analysis.\n'); 
end

if isCloseFigs
    close all; 
end

%% [frameNum] feature reconstruction 
%frameNum = 16330;
%reconstFrame = reconstructFeatureFromEigv(weights(frameNum,:), eigVectors, meanImgVec, imgWidth, imgHeight);
