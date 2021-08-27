function [samplesIndList, samplesIndList_global] = getRandSamples(nSets, listLength, heights)

samplesIndList = {};
samplesIndList_global = {};

minHeight = min(heights);
replacement = false;

for i = 1:nSets
    thisSamplesIndMat = [];
    thisSamplesInd_global = [];
    
    heightTot = 0;
    for j = 1:listLength
        y = randsample(heights(j), minHeight, replacement);
        y = sort(y);
        thisSamplesIndMat = [thisSamplesIndMat, y];
        
        thisSamplesInd_global = [thisSamplesInd_global; y + heightTot];
        heightTot = heightTot + heights(j);
    end
    
    samplesIndList{i} = thisSamplesIndMat;
    samplesIndList_global{i} = thisSamplesInd_global;
end

end