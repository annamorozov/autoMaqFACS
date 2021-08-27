function setupCopyGlobalAlignCoords(sourceWholeSubjPathMetaDir, targetWholeSubjPathMetaDir)

if ~exist(targetWholeSubjPathMetaDir, 'dir')
  mkdir(targetWholeSubjPathMetaDir);
end

copySubjGlobAlignParams(sourceWholeSubjPathMetaDir, targetWholeSubjPathMetaDir);

fprintf('Finished copying global alignment params for subject dir %s.\n', targetWholeSubjPathMetaDir);

