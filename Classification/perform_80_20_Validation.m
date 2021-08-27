function resPerf = perform_80_20_Validation(CVO, GTgroup, validLogicInd, testLogicInd, nTimes, pTest, experSubjInd)

classifPredictions = CVO.classifPredictions{1};

[classifPerf_singleClasses, classifPerf_singleTestSets] = ...
    calculateClassifPerf_SpecificInds(GTgroup, classifPredictions, validLogicInd, nTimes);

CVO_80_20.NumTestSets   = nTimes;
CVO_80_20.validLogicInd = validLogicInd;
CVO_80_20.testLogicInd  = testLogicInd;
CVO_80_20.pTest         = pTest;
CVO_80_20.GTgroup       = GTgroup;
CVO_80_20.experSubjInd  = experSubjInd;

resPerf.CVO = CVO_80_20;
resPerf.classifPerf_singleClasses_Valid = classifPerf_singleClasses;
resPerf.classifPerf_singleTestSets_Valid = classifPerf_singleTestSets;