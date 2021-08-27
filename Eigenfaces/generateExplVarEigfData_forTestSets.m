function generateExplVarEigfData_forTestSets(fullEigfmFilePath, fullEigfmFilePath_meanImgs, explVarEigfmFilePath, testSetInd, requestedExplVarVec,...
    imgWidth, imgHeight, isShow, figsSaveDir, isCloseFigs)

% Generate eigenfaces data for requested explained variances

mFile_explVarEigf = matfile(explVarEigfmFilePath, 'Writable', true);
mFile_explVarEigf.requestedExplVarVec(1,1:length(requestedExplVarVec)) = requestedExplVarVec;

%% Load the params of full eigenfaces
mFile_fullEigf = matfile(fullEigfmFilePath);
fullEigf = mFile_fullEigf.fullEigenfaces;

mFile_fullEigf_meanImgs = matfile(fullEigfmFilePath_meanImgs);
meanImgVec = cell2mat(mFile_fullEigf_meanImgs.MeanImgs(testSetInd,1));

%% Eigenfaces for requested expl. var.

for i = 1:length(requestedExplVarVec)
    
    explVar = requestedExplVarVec(i);
    eigfData4ExplVar = [];

    % Estimate eigenfaces parameters
    fprintf('Going to generate eigenfaces data for test set %d, expl. var. %f\n', testSetInd, explVar);
    
    thisFigsSaveDir = '';
    if isShow
       thisFigsSaveDirName = sprintf('explVarEigf__testSet_%d__explVar_%d', testSetInd, explVar*100); 
       thisFigsSaveDir = fullfile(figsSaveDir, thisFigsSaveDirName);
       
       if ~exist(thisFigsSaveDir, 'dir')
           mkdir(thisFigsSaveDir);
       end
    end
    
    if any(any(~isnan(fullEigf.eigValues)))
        [weights, eigVectors, nPCs, kneeExplVar] = generateEigfData4ExplVar(fullEigf.eigVectors, fullEigf.eigValues, fullEigf.nImgs, explVar, fullEigf.variancesMat,...
            imgWidth, imgHeight, isShow, thisFigsSaveDir, isCloseFigs, meanImgVec);

        fprintf('Finished generating eigenfaces data for test set %d, expl. var. %f\n', testSetInd, explVar);

        eigfData4ExplVar.requestedExplVar = explVar;
        eigfData4ExplVar.weights          = weights;
        eigfData4ExplVar.eigVectors       = eigVectors;
        eigfData4ExplVar.nPCs             = nPCs;
        eigfData4ExplVar.kneeExplVar      = kneeExplVar;
        eigfData4ExplVar.testSetInd       = testSetInd;
    else
        eigfData4ExplVar.requestedExplVar = explVar;
        eigfData4ExplVar.weights          = NaN;
        eigfData4ExplVar.eigVectors       = NaN;
        eigfData4ExplVar.nPCs             = NaN;
        eigfData4ExplVar.kneeExplVar      = NaN;
        eigfData4ExplVar.testSetInd       = testSetInd;
        fprintf('Skipping generating eigenfaces data for test set %d, expl. var. %f, eigen values are Nan\n', testSetInd, explVar);
    end

    % Save the eigenfaces for requested expl. var. to a matfile
    % Each row - different test set
    % Each column - eigenface data for different expl. var.

    mFile_explVarEigf.eigfData(testSetInd,i)     = eigfData4ExplVar;
    
end

    