function AU_FramesTbl_fromDBs = ...
    prepareSingleAUImgTbl_manyVids(AUsFramesTblsFileCol, DBRunDirCol, AU_2_classify,...
    minIntensityChar, isIgnoreStartStopPntFrames, isTakeAdjacentFrames, isOnlyPeakEvents)

% Prepare table of images of a single AU (from many videos)
%
% minIntensityChar           - optional param: 'a' or 'b' or 'c' or 'd' or 'e'
%                              In case we have constraint on AU intensity
% isIgnoreStartStopPntFrames - optional param: If 'true', won't take the AU point
%                              events and the AU events start and stop frames into
%                              the training set.
%                              The default value is 'false'.

if length(AUsFramesTblsFileCol) ~= length(DBRunDirCol)
    error('Different length of AUs frames tables column and DB run dir column!');
end

AU_FramesTbl_fromDBs = [];

len = length(AUsFramesTblsFileCol);
localFramesInd_AU_allVids  = cell(len,1);

if nargin < 5   % isIgnoreStartStopPntFrames
    isIgnoreStartStopPntFrames = false;
end

if nargin < 7   % isOnlyPeakEvents
    isOnlyPeakEvents = false;
end

for i=1:len
    load(AUsFramesTblsFileCol{i}, 'AUsInFramesTbl', 'training_matchedTimes_tbl',...
        'AUs_summary_tbl', 'AUs_all_tables');
    
    AU_matchedTimes_tbl = [];
    tblInd = find(strcmp(AUs_summary_tbl.Properties.VariableNames, AU_2_classify));
    if ~isempty(tblInd)
        if iscell(AUs_all_tables{tblInd,:}.AU_matchedTimes_tbl)
            AU_matchedTimes_tbl = AUs_all_tables{tblInd,:}.AU_matchedTimes_tbl{:,:};
        else
            AU_matchedTimes_tbl = AUs_all_tables{tblInd,:}.AU_matchedTimes_tbl(:,:);
        end
    end
      
    if nargin > 3 && ~isempty(minIntensityChar)   % minIntensityChar
        if ~isempty(tblInd)
            globalFramesInd_AU = getFramesInd4MinAuIntensity(minIntensityChar, AU_matchedTimes_tbl);
        else
            globalFramesInd_AU = [];
        end
    else
        globalFramesInd_AU = getFramesInd4SpecificAU(AUsInFramesTbl, AU_2_classify);
    end
    
    if isIgnoreStartStopPntFrames
        if ~isempty(AU_matchedTimes_tbl)
            globalFramesInd_AU_woSt = getFramesIndWoStartStopPnt(AU_matchedTimes_tbl);
            globalFramesInd_AU = intersect(globalFramesInd_AU, globalFramesInd_AU_woSt);
        end
    end
    
    if isOnlyPeakEvents
        if ~isempty(AU_matchedTimes_tbl)
            globalFramesInd_AU_peaks = getPeakEventsFramesInd(AU_matchedTimes_tbl);
            globalFramesInd_AU = intersect(globalFramesInd_AU, globalFramesInd_AU_peaks);
        end
    end
    
    if nargin > 5 && isTakeAdjacentFrames    % isTakeAdjacentFrames
        globalFramesInd_AU = takeAdjacentFrames(globalFramesInd_AU, training_matchedTimes_tbl);
    end
    
    if ~isempty(globalFramesInd_AU)
        localFramesInd_AU  = globalVidInd2Local(globalFramesInd_AU, training_matchedTimes_tbl);
    else
        localFramesInd_AU = [];
    end
    
    localFramesInd_AU_allVids{i} = localFramesInd_AU;
end

vidInd = find(~cellfun(@isempty,localFramesInd_AU_allVids));
if any(vidInd)
    AU_FramesTbl_fromDBs  = createDBSpecificFramesTbl_manyVids(DBRunDirCol(vidInd), localFramesInd_AU_allVids(vidInd));

    %Add labels column:
    [lblCol_AU{1:height(AU_FramesTbl_fromDBs)}]   = deal(AU_2_classify);

    AU_FramesTbl_fromDBs = [AU_FramesTbl_fromDBs,...
        array2table(lblCol_AU', 'VariableNames',{'label'})];
end

end

function globalFramesInd_AU = takeAdjacentFrames(globalFramesInd_AU, training_matchedTimes_tbl)
    globalFramesInd_AU_plus1fr  = globalFramesInd_AU + 1;
    globalFramesInd_AU_minus1fr = globalFramesInd_AU - 1;

    globalFramesInd_AU = union(globalFramesInd_AU, globalFramesInd_AU_plus1fr,  'sorted');
    globalFramesInd_AU = union(globalFramesInd_AU, globalFramesInd_AU_minus1fr, 'sorted');

    firstFrame = training_matchedTimes_tbl.Frame_n(1);
    lastFrame  = training_matchedTimes_tbl.Frame_n(end);
    
    globalFramesInd_AU = globalFramesInd_AU(globalFramesInd_AU >= firstFrame);
    globalFramesInd_AU = globalFramesInd_AU(globalFramesInd_AU <= lastFrame );
end

