function CVO = getCvPartition_LeaveOneSubjOut(FramesTbl_SubjNameCol, experSubjName)

% CV partition for testing generalization on subject. 
% Returns CVO object with all the cross-validation parameters.
% Each time take all the videos of [all-1] subjects for training, and leave
% all the videos of 1 subject for testing.

% experSubjName - optional param: name of the subject from the experiment
% (Fascicularis, not used for training)

[subjUnique, ~, iSubjUnique] = unique(FramesTbl_SubjNameCol);
%C = A(ia) and A = C(ic)

CVO = {};

training        = {};
test            = {};
testSubj        = {};
isTestExperSubj = zeros(length(subjUnique),1);

trainSubj = subjUnique;
iExperSubj = 0;

if nargin == 1   % experSubjName
    experSubjName = '';
else
    trainSubj = subjUnique(~strcmp(subjUnique, experSubjName));
    iExperSubj = find(strcmp(subjUnique, experSubjName));
end

% Experiment subject should be only in the test set, not training sets!
for i = 1:length(subjUnique)
    if i == iExperSubj
        isTestExperSubj(i) = true;
        
        test{i}     = find(iSubjUnique == i);
        training{i} = find(iSubjUnique ~= i);
    else
        test{i}     = find(iSubjUnique == i);
        training{i} = find((iSubjUnique ~= i) & (iSubjUnique ~= iExperSubj));
    end
    
    testSubj{i} = subjUnique(i);
end

CVO.NumTestSets     = length(subjUnique);
CVO.allSubj         = subjUnique;
CVO.training        = training;
CVO.test            = test;
CVO.trainSubj       = trainSubj;
CVO.testSubj        = testSubj; 
CVO.isTestExperSubj = isTestExperSubj;
