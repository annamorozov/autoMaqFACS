function [samplesIndList, samplesIndList_global] = getRandFramesTblsSamples(framesTblsFileNames, nSets)

fprintf('Going to generate random samples numbers for %d sets...\n', nSets);

%nSets = 10;
heights = [];

for i = 1:length(framesTblsFileNames)
    
    if size(framesTblsFileNames, 2) == 1
        loadedTbl = loadAndRenameVar(framesTblsFileNames{i});
    else
        loadedTbl = loadAndRenameVar(framesTblsFileNames{i,1}, framesTblsFileNames{i,2});
    end
    
    h = height(loadedTbl);
    heights = [heights, h];
    
    clear('loadedTbl');
end

[samplesIndList, samplesIndList_global] = getRandSamples(nSets, length(framesTblsFileNames), heights);
    
fprintf('Finished generating random samples numbers for %d sets.\n', nSets);
end





