function sumAUsInFramesTbl = sumAUsInFramesTbls(AUsFramesTblsFileCol, isSubjectsSum)

% The function creates a summary table of AUs in frames of all videos.
% isSubjectsSum - optional param

if nargin < 2   % isSubjectsSum
    isSubjectsSum = false;
end

sumAUsInFramesTbl = {};

for i = 1:length(AUsFramesTblsFileCol)
    if ~exist(AUsFramesTblsFileCol{i}, 'file')
        fprintf('No AUsInFramesTbl in %s.\n', AUsFramesTblsFileCol{i});
        continue;
    end
    
    varName = 'AUsInFramesTbl';
    if isSubjectsSum
        varName = 'subjAUsInFramesTbl';
    end
    
    AUsInFramesTbl = loadAndRenameVar(AUsFramesTblsFileCol{i}, varName);
    %load(AUsFramesTblsFileCol{i}, 'AUsInFramesTbl');
    
    if i == 1
        sumAUsInFramesTbl = AUsInFramesTbl;
        continue;
    end
    
    sumAUsInFramesTbl = sum2AUsInFramesTbls(sumAUsInFramesTbl, AUsInFramesTbl);
end

