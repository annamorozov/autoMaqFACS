function setupMakeAUsGroupsHistograms(AusAnalysisDirCol, groupSize, vidName4Hist, histType)

% The function creates and saves AUs groups frequencies histogram for each video.
% histType: 1 or 2. 1 - regular histogram, 2 - histogram vs. chance level
%                                              events

for i = 1:length(AusAnalysisDirCol)
    tblName = sprintf('AuGroupsFreqTbl_%d', groupSize);
    matFileName = sprintf('%s.mat', tblName);
    fullFilename = fullfile(AusAnalysisDirCol{i}, matFileName);
    
    if exist(fullFilename, 'file') ~= 2
        continue;
    end
    
    load(fullFilename, 'AuGroupsFreqTbl');
    
    if isempty(AuGroupsFreqTbl)
        continue;
    end
        
    switch histType
       case 1
           titleStr = sprintf('Histogram of each %d AUs from video %s', groupSize, vidName4Hist{i});
           histHandle = getAUsGroupsHistogram(AuGroupsFreqTbl, titleStr);
           
           figFileName = sprintf('AuGroupsFreqHist_%d.fig', groupSize);
       case 2
           titleStr = sprintf('Histogram VS chance level of each %d AUs from video %s', groupSize, vidName4Hist{i});
           histHandle = getAUsGroupsHistVsChanceEvents(AuGroupsFreqTbl, titleStr);
           
           figFileName = sprintf('AuGroupsFreqHistVsChance_%d.fig', groupSize);
       otherwise
          error('The histogram type should be 1 or 2!');
    end

    if ~isempty(histHandle)
        saveDir = AusAnalysisDirCol{i};
        saveas(histHandle, fullfile(saveDir, figFileName));
    else
        fprintf('For video %s there were no groups of %d AUs.\n', vidName4Hist{i}, groupSize);
    end
end

