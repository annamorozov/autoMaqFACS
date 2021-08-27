function [labelIndicesList, isEnoughLabels, isEnoughLabelSamples] = ...
    makeLabelIndicesList_wMinLabels(fullFramesTbl_labelCol, trialFramesInd, minLblsInSet, nMinLabelSamples)

        labelIndicesList     = {};
        isEnoughLabels       = true;
        isEnoughLabelSamples = true;
        
        heights = [];

        [uTrialLbls, ~, iUTrialLbls] = unique(fullFramesTbl_labelCol(trialFramesInd));

        for j=1:length(uTrialLbls)
            iInd = (iUTrialLbls == j);
            labelIndicesList{j} = trialFramesInd(iInd);
            
            h = length(labelIndicesList{j});
            heights = [heights, h];
        end
        
        isEnoughLabels = (length(labelIndicesList) >= minLblsInSet);
        
        minHeight = min(heights);
        if minHeight < nMinLabelSamples
            isEnoughLabelSamples = false;
        end
end