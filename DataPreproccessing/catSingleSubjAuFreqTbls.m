function catFreqTbl = catSingleSubjAuFreqTbls(AUsFramesTblsFileCol, bAddRowSubjName, ROItype)
% Concatenate AUs frequency tables for a single subject

% ROItype - optional param:
% 1 = upper face
% 2 = lower face

catFreqTbl = [];

for i = 1:length(AUsFramesTblsFileCol)
    load(AUsFramesTblsFileCol{i}, 'AUs_summary_tbl');
    
    % For debug
    %fprintf('%s\n',AUsFramesTblsFileCol{i});
        
    if nargin > 2  % ROItype
        AUs_summary_tbl = getROI_AUs_summary_tbl(AUs_summary_tbl, ROItype);
    end
    
    countTbl = AUs_summary_tbl({'Count'},:);
    
    if bAddRowSubjName
        [dirName, ~, ~] = fileparts(AUsFramesTblsFileCol{i});
        [vidPath, ~, ~] = fileparts(dirName);
        [~, vidName, ~] = fileparts(vidPath);
        
        countTbl.Properties.RowNames = {vidName};
    end
      
    if i == 1        
        catFreqTbl = countTbl;
        continue;
    else
        % Handle the tables in pairs, in an incremental way
        catFreqTbl = cat2tbls(catFreqTbl, countTbl);
    end
    
end