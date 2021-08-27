function res = sumClassifPerf4SpecificClass_f1(classifPerf_singleClass)

res.ErrorRate = classifPerf_singleClass.ErrorRate;
res.Recall    = classifPerf_singleClass.Sensitivity;
res.Precision = classifPerf_singleClass.PositivePredictiveValue;

res.F1        = 2*(res.Precision*res.Recall)/(res.Precision+res.Recall);

res.Labels      = strjoin(classifPerf_singleClass.ClassLabels,',');
res.TgtClasses  = strjoin(classifPerf_singleClass.ClassLabels(classifPerf_singleClass.TargetClasses),',');
res.CtrlClasses = strjoin(classifPerf_singleClass.ClassLabels(classifPerf_singleClass.ControlClasses),',');

res.SamplesPerClass = classifPerf_singleClass.SampleDistributionByClass';