function copySubjGlobAlignParams(sourceSubjMetaDir, targetSubjMetaDir) 

fSrcGlobAlignParams = fullfile(sourceSubjMetaDir, 'globalAlignParams.mat');
fTgtGlobAlignParams = fullfile(targetSubjMetaDir, 'globalAlignParams.mat');

if ~copyfile(fSrcGlobAlignParams, fTgtGlobAlignParams)
    error('Couldnt copy %s file to %s', fSrcGlobAlignParams, fTgtGlobAlignParams);
end
