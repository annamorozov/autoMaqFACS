function setupPlotVidAUsFlow(AusAnalysisDirCol, AUsFramesTblsFileCol, AUsInFramesTblFileCol, vidName4Flow)

for i = 1:length(AUsFramesTblsFileCol)
    if ~exist(AUsFramesTblsFileCol{i}, 'file')
        fprintf('File %s doesnt exist.\n', AUsFramesTblsFileCol{i});
        continue;
    end
    
    if ~exist(AUsInFramesTblFileCol{i}, 'file')
        fprintf('File %s doesnt exist.\n', AUsInFramesTblFileCol{i});
        continue;
    end
    
    load(AUsFramesTblsFileCol{i}, 'AUs_all_tables', 'training_matchedTimes_tbl');
    load(AUsInFramesTblFileCol{i}, 'AUsInFramesTbl');
    
    [~, neutralFrames_GlobalIndx] = getNeutralFrames(AUs_all_tables, training_matchedTimes_tbl);
    figHandle = plotAUsFlow(AUsInFramesTbl, vidName4Flow{i}, neutralFrames_GlobalIndx);
 
    savefig(figHandle, fullfile(AusAnalysisDirCol{i},'AUsFlow.fig'));
end