function fullTbl = loadFramesTblsList(framesTblsPathList, samplesIndMat,...
    framesTblsPathList_trainOnlyInd)

% samplesIndMat, framesTblsPathList_trainOnlyInd - optional params

fullTbl = [];

% Each table is a different AU. At the end there may be also tables of
% experiment subj. different AUs. 
for i = 1:length(framesTblsPathList)
    
    if size(framesTblsPathList, 2) == 1
        loadedTbl = loadAndRenameVar(framesTblsPathList{i});
    else
        loadedTbl = loadAndRenameVar(framesTblsPathList{i,1}, framesTblsPathList{i,2});
    end
    
    if nargin > 2   % framesTblsPathList_trainOnlyInd
        if ismember(i, framesTblsPathList_trainOnlyInd)
            % The training only frames tables are always at the beginning
            thisSetInd = samplesIndMat(:,i);
            loadedTbl = loadedTbl(thisSetInd,:);
        end
    end
    
    fullTbl = [fullTbl; loadedTbl];
    clear('loadedTbl');
end