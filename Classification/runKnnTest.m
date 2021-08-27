function mdlsArr =  runKnnTest(resSaveDir, requestedExplVar, numNeighbors, distanceMetric,...
    framesTbl, imgSizePath, CVO, isComputeEigf, fullEigfmFilePath_meanImgs, explVarEigfmFilePath, isSaveMdl)
% Train and validate the KNN classifiers

mdlsArr = {};

try
    fprintf('runKnnTest: running for params:\n resSaveDir = %s\n requestedExplVar = %f, numNeighbors = %d...\n',...
        resSaveDir, requestedExplVar, numNeighbors);

    % Generate paths for results
    [resSavePath, ~] = generateKnnTestResPaths(resSaveDir,...
        'requestedExplVar', requestedExplVar, 'numNeighbors', numNeighbors, 'distanceMetric', distanceMetric);
    
    tic
    
    [~, ~, mdlsArr] = evaluateKnn(framesTbl, CVO, imgSizePath, resSavePath, numNeighbors,...
        distanceMetric, isComputeEigf, fullEigfmFilePath_meanImgs, explVarEigfmFilePath, requestedExplVar, isSaveMdl);
  
    toc
    
%TODO: fix the printed text
catch ME
    msg = sprintf('Exception during running for resSaveDir = %s reqExplVar = %f, numNeighb = %d, distanceMetric = %s',...
        resSaveDir, requestedExplVar, numNeighbors, distanceMetric);
    causeException = MException('runKnnTest:failure',msg);
    ME = addCause(ME,causeException);
    rethrow(ME)
end