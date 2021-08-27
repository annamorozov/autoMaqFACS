function [testLogicInd, validLogicInd] = getValidAndTestPartition(GTgroup, pTest, nTimes)

% pTest - proportion of test
% nTimes - optional param: number of repartition repetitions

% Randomly partitions observations into a training set and a holdout 
%(or test) set with stratification, using the class information in group. 
% Both the training and test sets have roughly the same class proportions as in group.
% When 0 < p < 1, cvpartition randomly selects approximately p*n 
% observations for the test set.

%p = 0.2;

c = cvpartition(GTgroup,'HoldOut',pTest);

testLogicInd = c.test;
validLogicInd = c.training;

if nargin > 2   % nTimes
    for i = 1:(nTimes-1)
        cnew = repartition(c);
        
        testLogicInd  = [testLogicInd, cnew.test];
        validLogicInd = [validLogicInd, cnew.training];
    end
end

