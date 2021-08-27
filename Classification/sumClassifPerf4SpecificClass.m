function res = sumClassifPerf4SpecificClass(classifPerf_singleClass)

res.ErrorRate   = classifPerf_singleClass.ErrorRate;
res.Sensitivity = classifPerf_singleClass.Sensitivity;
res.Specificity = classifPerf_singleClass.Specificity;

res.Labels      = strjoin(classifPerf_singleClass.ClassLabels,',');
res.TgtClasses  = strjoin(classifPerf_singleClass.ClassLabels(classifPerf_singleClass.TargetClasses),',');
res.CtrlClasses = strjoin(classifPerf_singleClass.ClassLabels(classifPerf_singleClass.ControlClasses),',');