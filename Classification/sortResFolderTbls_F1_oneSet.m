function [sumTbl_sorted, best3Rows] = sortResFolderTbls_F1_oneSet(resFolderTbls, ROItype, isCVresCol)

% ROItype    - 1 = upper face, 2 = lower face
% isCVresCol - optional param: are the results for computation should be
%              taken from _CV columns (if true) or from _ExperTest (if false)

if nargin < 3   % isCVresCol
    isCVresCol = false;
end

if ROItype == 1 % upper
    resTbl1 = resFolderTbls{2,1};
    resTbl2 = resFolderTbls{2,2};
    resTbl3 = resFolderTbls{1,3};

    f1Name1 = 'AU1_2_f1';
    f1Name2 = 'AU43_f1';
    f1Name3 = 'Neutral_f1';
    
elseif ROItype == 2 % lower
    
    resTbl1 = resFolderTbls{2,2};
    resTbl2 = resFolderTbls{2,3};
    resTbl3 = resFolderTbls{1,1};
    
    f1Name1 = 'AU256_16_f1';
    f1Name2 = 'AU256_18i_f1';
    f1Name3 = 'AU256_f1';
else
    error('ROItype must be either 1 or 2!');
end

resTbl1 = sortrows(resTbl1,'testName','ascend');
resTbl2 = sortrows(resTbl2,'testName','ascend');
resTbl3 = sortrows(resTbl3,'testName','ascend');

errorCol_name = 'errorRate_ExperTest';
f1Col_name = 'f1_ExperTest';
if isCVresCol
    errorCol_name = 'errorRate_CV';
    f1Col_name = 'f1_CV';
end

classWeights = resTbl1.sampPerClass_CV{1}; 
if ROItype == 2 % lower
    classWeights = [classWeights(2), classWeights(3), classWeights(1)];
end

f1_perClass = [resTbl1.(f1Col_name), resTbl2.(f1Col_name), resTbl3.(f1Col_name)];

f1_w = sum((classWeights.*f1_perClass)')'/sum(classWeights);


sumTbl = table(resTbl1.testName, resTbl1.(errorCol_name), resTbl1.(f1Col_name), resTbl2.(f1Col_name), resTbl3.(f1Col_name),...
    'VariableNames',{'testName', 'errorRate', f1Name1, f1Name2, f1Name3});  

sumTbl.f1_Avg = nanmean(sumTbl{:,{f1Name1, f1Name2, f1Name3}}, 2);
sumTbl.f1_w = f1_w;

sumTbl.classWeigts = cell(height(sumTbl),1);
sumTbl.classWeigts(:)={classWeights};


sumTbl_sorted = sortrows(sumTbl,{'f1_w'}, 'descend');

nSortRows = min(3, height(sumTbl_sorted));
best3Rows = sumTbl_sorted(1:nSortRows,:);
