function crossValidate_gener2NewSubj_file(filename, experSubjName)

if nargin < 2   % experSubjName
    experSubjName = '';
end

cp = load(filename);

[CVO_gener2NewSubj,...
    classifPerf_singleClasses_gener2NewSubj,...
    classifPerf_singleTestSets_gener2NewSubj] =...
    crossValidate_gener2NewSubj(cp.CVO.sourceTbl, cp.CVO.allPredictions, experSubjName);

cp.CVO_gener2NewSubj = CVO_gener2NewSubj;
cp.classifPerf_singleClasses_gener2NewSubj = classifPerf_singleClasses_gener2NewSubj;
cp.classifPerf_singleTestSets_gener2NewSubj = classifPerf_singleTestSets_gener2NewSubj;

save(filename, '-struct', 'cp');