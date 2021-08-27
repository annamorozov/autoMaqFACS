function setupMakeAUsGroupsFreqTbls(AUsFramesTblsFileCol, AusAnalysisDirCol,...
    groupSize, ROItype)

% The function creates and saves AUs groups frequencies table for each video.

% ROItype - optional param:
% 1 = upper face
% 2 = lower face

for i = 1:length(AUsFramesTblsFileCol)
    load(AUsFramesTblsFileCol{i}, 'AUs_summary_tbl');
    
    if nargin > 3   % ROItype
        AUs_summary_tbl = getROI_AUs_summary_tbl(AUs_summary_tbl, ROItype);
    end
    
    AuGroupsFreqTbl = createAUsGroupsFreqTbl(AUs_summary_tbl, groupSize);
    if isempty(AuGroupsFreqTbl)
        continue;
    end
    
    saveDir = AusAnalysisDirCol{i};
    if ~exist(saveDir, 'dir')
        mkdir(saveDir);
    end

    tblName = sprintf('AuGroupsFreqTbl_%d', groupSize);
    matFileName = sprintf('%s.mat', tblName);
    save(fullfile(saveDir, matFileName), 'AuGroupsFreqTbl');
end
