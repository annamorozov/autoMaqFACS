function [sumTbl_sorted, best3Rows] = sortResFolderTbls_Sensitivity_oneSet(resFolderTbls, ROItype, isCVresCol, isPeaks)

% ROItype    - 1 = upper face, 2 = lower face
% isCVresCol - optional param: are the results for computation should be
%              taken from _CV columns (if true) or from _ExperTest (if false)

if nargin < 3   % isCVresCol
    isCVresCol = false;
end

if nargin < 4   % isPeaks
    isPeaks = false;
end

if ROItype == 1 % upper
    
    if isPeaks
        resTbl1 = resFolderTbls{2, 3} ;
        resTbl2 = resFolderTbls{2, 1};
        resTbl3 = resFolderTbls{1, 2} ;
    else
        resTbl1 = resFolderTbls{2,1};
        resTbl2 = resFolderTbls{2,2};
        resTbl3 = resFolderTbls{1,3};
    end
    
    sensName1 = 'AU1_2_sens';
    sensName2 = 'AU43_sens';
    sensName3 = 'Neutral_sens';
    
elseif ROItype == 2 % lower
    
    resTbl1 = resFolderTbls{2,2};
    resTbl2 = resFolderTbls{2,3};
    resTbl3 = resFolderTbls{1,1};
    
    sensName1 = 'AU256_16_sens';
    sensName2 = 'AU256_18i_sens';
    sensName3 = 'AU256_sens';
else
    error('ROItype must be either 1 or 2!');
end

resTbl1 = sortrows(resTbl1,'testName','ascend');
resTbl2 = sortrows(resTbl2,'testName','ascend');
resTbl3 = sortrows(resTbl3,'testName','ascend');

errorCol_name = 'errorRate_ExperTest';
sensitivityCol_name = 'Sensitivity_ExperTest';
if isCVresCol
    errorCol_name = 'errorRate_CV';
    sensitivityCol_name = 'Sensitivity_CV';
end


sumTbl = table(resTbl1.testName, resTbl1.(errorCol_name), resTbl1.(sensitivityCol_name), resTbl2.(sensitivityCol_name), resTbl3.(sensitivityCol_name),...
    'VariableNames',{'testName', 'errorRate', sensName1, sensName2, sensName3});  

sumTbl.sensAvg = nanmean(sumTbl{:,{sensName1, sensName2, sensName3}}, 2);

sumTbl_sorted = sortrows(sumTbl,{'sensAvg'}, 'descend');

nSortRows = min(3, height(sumTbl_sorted));
best3Rows = sumTbl_sorted(1:nSortRows,:);
