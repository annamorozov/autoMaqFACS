function setupMakeAUsFreqHistograms(AUsFramesTblsFileCol, AusAnalysisDirCol,...
    vidName4Hist, ROItype)

% The function creates and saves AUs frequencies histogram for each video.

for i = 1:length(AUsFramesTblsFileCol)
    
    load(AUsFramesTblsFileCol{i}, 'AUs_summary_tbl');
    
    if nargin > 3   % ROItype
        AUs_summary_tbl = getROI_AUs_summary_tbl(AUs_summary_tbl, ROItype);
    end
    
    if isempty(AUs_summary_tbl) || height(AUs_summary_tbl) < 1
        continue;
    end
    
    AuNamesList = AUs_summary_tbl{{'OrigPtrn'},:};
    AuFreqList = AUs_summary_tbl{{'Count'},:};
    
    titleStr = sprintf('Histogram of AUs frequencies from video %s', vidName4Hist{i});
    figFileName = sprintf('AUsFreqHist.fig');
    
    histHandle = getAUsFreqHistogram(AuNamesList, AuFreqList, titleStr);
    
    saveDir = AusAnalysisDirCol{i};
    if ~exist(saveDir, 'dir')
        mkdir(saveDir);
    end
    
    saveas(histHandle, fullfile(saveDir, figFileName));
end

