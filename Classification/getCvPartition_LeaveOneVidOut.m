function CVO = getCvPartition_LeaveOneVidOut(fullFramesTbl_TrialNameCol, fullFramesTbl_SubjNameCol,...
    cvType, samplesInd_global, subjToExclude, fullFramesTbl_labelCol, isRestrictTest_minLbl)

    % subjToExclude          - optional param
    % fullFramesTbl_labelCol - optional param. If specified, the proportion of 
    %                          labels samples is taken into account 
    %                          (train sets with not enough samples will be excluded). 
    % isRestrictTest_minLbl  - optional param. If true, the test sets will be selected according
    %                          to minimal numbers of labels and frames in
    %                          the set. fullFramesTbl_labelCol must be
    %                          specified with this param.

    % CV partition for testing generalization on a video within subject. 
    % Each time take [all-1] videos of one subject for training, and leave 1 video
    % of the same subject video for testing.
    % Returns CVO object with all the cross-validation parameters.

    
    if nargin < 4 || isempty(samplesInd_global)  % samplesInd_global
        samplesInd_global = 1:length(fullFramesTbl_TrialNameCol);
    end
    
    if nargin < 7   % isRestrictTest_minLbl
        isRestrictTest_minLbl = false;
    end

    [trialUnique, ~, iTrialUnique] = unique(fullFramesTbl_TrialNameCol);
    %C = A(ia) and A = C(ic)

    CVO = {};

    training        = {};
    test            = {};
    testTrial       = {};
    trainTrial      = {};

    numTestSets = 0;
    allTrials   = {};
    
    nMinLabelSamples_Train = 10;
    nMinLabelSamples_Test = 5;

    minLblsInTrainSet = 3; 
    minLblsInTestSet  = 3; 

    for i = 1:length(trialUnique)
        % The test trial
        iTest      = find(iTrialUnique == i);

        % The subject of the test trial
        testSubj     = unique(fullFramesTbl_SubjNameCol(iTest));
        if length(testSubj)>1
            error('There are more than 1 subject for trial %s!', iTest);
        end

        if nargin > 4 && ~isempty(subjToExclude)    % subjToExclude
            if strcmp(subjToExclude, testSubj)
                continue;
            end
        end

        if strcmp(cvType, 'oneVidOut')
            % All other trials, but NOT from the same subject
            trainInd = find(~(strcmp(fullFramesTbl_SubjNameCol, testSubj)));
        elseif strcmp(cvType, 'sameSubjOneVidOut')
            % All other trials, but from the SAME subject
            trainInd = find((iTrialUnique ~= i) & (strcmp(fullFramesTbl_SubjNameCol, testSubj)));
        else
            error('cvType must be either oneVidOut or sameSubjOneVidOut');
        end
            
        thisTraining = intersect(trainInd, samplesInd_global);

        thisTestTrial  = trialUnique(i);
        thisTrainTrial = unique(fullFramesTbl_TrialNameCol(thisTraining));

        if nargin > 5   % fullFramesTbl_labelCol
            
            isEnoughLabels_Test = true;
            isEnoughLabelSamples_Test = true;
            
            if isRestrictTest_minLbl
            % Check if there is enough labels and frames in the test set
            [~, isEnoughLabels_Test, isEnoughLabelSamples_Test] = ...
                makeLabelIndicesList_wMinLabels(fullFramesTbl_labelCol, iTest, minLblsInTestSet, nMinLabelSamples_Test);
            end
                       
            [labelIndicesList_Train, isEnoughLabels_Train, isEnoughLabelSamples_Train] = ...
                makeLabelIndicesList_wMinLabels(fullFramesTbl_labelCol, thisTraining, minLblsInTrainSet, nMinLabelSamples_Train);
            
            if ~(isEnoughLabels_Test && isEnoughLabelSamples_Test && isEnoughLabels_Train && isEnoughLabelSamples_Train)
                continue;
            end

            % Build the balanced training set
            nSets =  1;
            samplesIndList = getRandFramesTblsSamples_lblInd(labelIndicesList_Train, nSets);
            
            indMat = samplesIndList{1};
            thisTraining = reshape(indMat,[numel(indMat),1]);
        end
        
        numTestSets       = numTestSets+1;
        allTrials         = [allTrials; trialUnique{i}];

        testTrial{numTestSets}  = thisTestTrial;
        trainTrial{numTestSets} = thisTrainTrial;
        
        test{numTestSets}     =  iTest;
        training{numTestSets} = thisTraining;
    end

    CVO.NumTestSets     = numTestSets;
    CVO.allTrials       = allTrials;
    CVO.training        = training;
    CVO.test            = test;
    CVO.trainTrial      = trainTrial;
    CVO.testTrial       = testTrial; 

    CVO.nMinLabelSamples_Train = nMinLabelSamples_Train;
    CVO.nMinLabelSamples_Test  = nMinLabelSamples_Test;
    CVO.minLblsInTrainSet      = minLblsInTrainSet; 
    CVO.minLblsInTestSet       = minLblsInTestSet; 
end
