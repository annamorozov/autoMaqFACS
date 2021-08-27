function CVO = getCvPartition_LeaveOneSubjOut_Rhesus(fullFramesTbl_SubjNameCol,...
    samplesInd_global, subjToExclude, fullFramesTbl_labelCol, isRestrictTest_minLbl)

    % subjToExclude          - optional param
    % fullFramesTbl_labelCol - optional param. If specified, the proportion of 
    %                          labels samples is taken into account 
    %                          (train sets with not enough samples will be excluded). 
    % isRestrictTest_minLbl  - optional param. If true, the test sets will be selected according
    %                          to minimal numbers of labels and frames in
    %                          the set. fullFramesTbl_labelCol must be
    %                          specified with this param.

    % CV partition for testing generalization on a video across subjects (Rhesus). 
    % Each time take [all-1] subjects for training, and leave 1 subject for testing.
    % Returns CVO object with all the cross-validation parameters.

    
    if nargin < 2 || isempty(samplesInd_global)  % samplesInd_global
        samplesInd_global = 1:length(fullFramesTbl_SubjNameCol);
    end
    
    if nargin < 5   % isRestrictTest_minLbl
        isRestrictTest_minLbl = false;
    end

    [subjUnique, ~, iSubjUnique] = unique(fullFramesTbl_SubjNameCol);
    %C = A(ia) and A = C(ic)

    CVO = {};

    training        = {};
    test            = {};
    testSubj        = {};
    trainSubj       = {};

    numTestSets = 0;
    allSubjects   = {};
    
    nMinLabelSamples_Train = 10;
    nMinLabelSamples_Test = 31;

    minLblsInTrainSet = 3; 
    minLblsInTestSet  = 3; 

    for i = 1:length(subjUnique)
        % The test trial
        iTest      = find(iSubjUnique == i);
        thisTestSubj   = subjUnique(i);

        if nargin > 2 && ~isempty(subjToExclude)    % subjToExclude
            if strcmp(subjToExclude, thisTestSubj)
                continue;
            end
        end

        trainInd = find(~(strcmp(fullFramesTbl_SubjNameCol, thisTestSubj)));
        thisTraining = intersect(trainInd, samplesInd_global);

        thisTrainSubj = unique(fullFramesTbl_SubjNameCol(thisTraining));

        if nargin > 3   % fullFramesTbl_labelCol
            
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

            % Build the training set
            nSets =  1;
            samplesIndList = getRandFramesTblsSamples_lblInd(labelIndicesList_Train, nSets);
            
            indMat = samplesIndList{1};
            thisTraining = reshape(indMat,[numel(indMat),1]);
        end
        
        numTestSets       = numTestSets+1;
        allSubjects         = [allSubjects; subjUnique{i}];

        testSubj{numTestSets}  = thisTestSubj;
        trainSubj{numTestSets} = thisTrainSubj;
        
        test{numTestSets}     =  iTest;
        training{numTestSets} = thisTraining;
    end

    CVO.NumTestSets    = numTestSets;
    CVO.allSubj        = allSubjects;
    CVO.training       = training;
    CVO.test           = test;
    CVO.trainSubj      = trainSubj;
    CVO.testSubj       = testSubj; 

    CVO.nMinLabelSamples_Train = nMinLabelSamples_Train;
    CVO.nMinLabelSamples_Test  = nMinLabelSamples_Test;
    CVO.minLblsInTrainSet      = minLblsInTrainSet; 
    CVO.minLblsInTestSet       = minLblsInTestSet; 
    CVO.isRestrictTest_minLbl  = isRestrictTest_minLbl;
end
