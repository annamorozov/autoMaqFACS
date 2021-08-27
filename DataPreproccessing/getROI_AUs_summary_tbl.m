function ROI_AUs_summary_tbl = getROI_AUs_summary_tbl(AUs_summary_tbl, ROItype)
% Get AUs_summary_tbl for specific ROI
% ROItype:
% 1 = upper face
% 2 = lower face

AUsDict = initializeROIsAUsDictionary();
ROI_AUs = {};

switch ROItype
    case 1
        ROI_AUs = keys(AUsDict.upperFaceAUsMap);
    case 2
        ROI_AUs = keys(AUsDict.lowerFaceAUsMap);
    otherwise
        error('Wrong ROItype! Only 1 or 2 are allowed in this context.');
end

[~, LocSumTbl] = ismember(ROI_AUs,AUs_summary_tbl{{'OrigPtrn'},:});
roiColsInd = LocSumTbl(LocSumTbl ~= 0);
roiColsInd = sort(roiColsInd);

ROI_AUs_summary_tbl = AUs_summary_tbl(:,roiColsInd);