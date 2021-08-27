function samplesIndList = getRandFramesTblsSamples_lblInd(labelIndicesList, nSets)

if nargin < 2   % nSets
    nSets  = 1;
end

fprintf('Going to generate random samples numbers for %d sets...\n', nSets);

%nSets = 10;
heights = [];
samplesIndList = {};

len = length(labelIndicesList);

for i = 1:len
    h = length(labelIndicesList{i});
    heights = [heights, h];
end

[relativeSamplesIndList, ~] = getRandSamples(nSets, len, heights);

% Convert to actual list indices
for i = 1:length(relativeSamplesIndList)
    relIndMat = relativeSamplesIndList{i};
    
    thisSamplesIndMat = [];
    for j = 1:size(relIndMat,2)
        relInd = relIndMat(:,j);
        y = labelIndicesList{j}(relInd);
        
        thisSamplesIndMat = [thisSamplesIndMat, y];
    end
    
    samplesIndList{i} = thisSamplesIndMat;
end
    
fprintf('Finished generating random samples numbers for %d sets.\n', nSets);
end