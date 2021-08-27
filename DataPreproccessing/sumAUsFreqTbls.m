function sumFreqTbl = sumAUsFreqTbls(AUsFramesTblsFileCol, ROItype)

% The function creates a summary table of AUs frequencies 
% for all the training videos of the subject.

% ROItype - optional param:
% 1 = upper face
% 2 = lower face

sumFreqTbl = [];

for i = 1:length(AUsFramesTblsFileCol)
    load(AUsFramesTblsFileCol{i}, 'AUs_summary_tbl', 'neutralFramesInd');
        
    if nargin > 1   % ROItype
        AUs_summary_tbl = getROI_AUs_summary_tbl(AUs_summary_tbl, ROItype);
    end
    
    countTbl = AUs_summary_tbl({'Count'},:);
    
    if exist('neutralFramesInd')
        Neural_wholeFace = length(neutralFramesInd.neutralFrames_Abs_GlobalIndx);

        countTbl = [countTbl, {{Neural_wholeFace}}];
        countTbl.Properties.VariableNames{end} = 'Neutral_wholeFace';
    end
   
    if i == 1        
        sumFreqTbl = countTbl;
        continue;
    else
        % Handle the tables in pairs, in an incremental way
        sumFreqTbl = sum2FreqTblsOfAUs(sumFreqTbl, countTbl);
    end
    
end

