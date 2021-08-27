function AU_matchedTimes_tbl = getAuAllTimes(au_table, vidTimesVec, accuracy)

% Finds all the corresponding times for a particular AU in the video (observer xls contains only the observer
% times).

if nargin < 3 
    accuracy = 0.0334;  % 1/(FrameRate = 29.9700)
end

%load('C:\Users\Anna\Documents\Paz Lab\MaqFACS\For Analysis\Lisa Parr - G_10012_X1\18345_FramesCropped\MetaData\timesVes.mat');
isAddTrainFrames = false;
matchedTimes_tbl = getClosestTimes(au_table.Time_Relative_sf, vidTimesVec, isAddTrainFrames);

% Add Event_Type and Error columns
matchedTimes_tbl = [matchedTimes_tbl cell2table(au_table.Event_Type, 'VariableNames',{'Event_Type'})];
matchedTimes_tbl = [matchedTimes_tbl array2table(zeros(size(matchedTimes_tbl,1),1), 'VariableNames', {'Error'})];

for i=1:size(au_table,1)-1
    % We are at start state
    if(strcmp(au_table.Event_Type{i},'State start'))
        thisTime     = au_table.Time_Relative_sf(i);
        thisDuration = au_table.Duration_sf(i);
        nextStopTime     = au_table.Time_Relative_sf(i+1);
        iNext = i+1;
        
        if ~(strcmp(au_table.Event_Type{i+1},'State stop')) && ~(strcmp(au_table.Event_Type{i+1},'Point'))
            % The next after "start" is not "stop" or "point"
            matchedTimes_tbl.Error(i) = 1;
            continue;
        end
           
        % The next after "start" is "point"
        if strcmp(au_table.Event_Type{i+1},'Point')
            
            % check the one after "point"
            if (i+2 <= length(au_table.Time_Relative_sf))
                % the one after is "stop"
                if strcmp(au_table.Event_Type{i+2},'State stop')
                    nextStopTime = au_table.Time_Relative_sf(i+2);
                    iNext = i+2;
                
                % the one after is "point"
                elseif strcmp(au_table.Event_Type{i+2},'Point')
                    % two or more after is "stop" (the legal option is "point" or "stop")
                    j = 3;
                    while(i+j <= length(au_table.Time_Relative_sf)) && strcmp(au_table.Event_Type{i+j},'Point')
                        j = j+1;
                    end
                    
                    if (strcmp(au_table.Event_Type{i+j},'State stop'))
                        nextStopTime = au_table.Time_Relative_sf(i+j);
                        iNext = i+j;
                    else
                        matchedTimes_tbl.Error(i) = 4;
                        continue;
                    end
                    
%                     if (i+3 <= length(au_table.Time_Relative_sf)) && strcmp(au_table.Event_Type{i+3},'State stop')
%                         nextStopTime = au_table.Time_Relative_sf(i+3);
%                         iNext = i+3;
%                     else
%                         matchedTimes_tbl.Error(i) = 4;
%                         continue;
%                     end
                end
                
            else
                matchedTimes_tbl.Error(i) = 4;
                continue;
            end
        end
            
        if ~((thisTime + thisDuration <= nextStopTime + accuracy) && ...
            (thisTime + thisDuration >= nextStopTime - accuracy))
            % start_time + duration ~= stop_time
            matchedTimes_tbl.Error(i) = 2;
        else
            % Add the intermidiate times
            matchedTimes_tbl = addIntermidiateTimes(vidTimesVec, matchedTimes_tbl, i, iNext);
        end
        
    % We are at stop state
    elseif(strcmp(au_table.Event_Type{i},'State stop'))
        if(strcmp(au_table.Event_Type{i+1},'State stop'))
            % The next after "stop" is "stop" again
            matchedTimes_tbl.Error(i) = 3;
        end
     end
end

% Filter the rows
if ~all(strcmp(matchedTimes_tbl.Event_Type,'Point'))
    AU_matchedTimes_tbl = filterRows(matchedTimes_tbl);
else
    AU_matchedTimes_tbl = matchedTimes_tbl;
end

% Add meta data
meta_data.Behav = au_table.Behavior(1);
meta_data.Behav_filt = au_table.Behavior_filtered(1);
AU_matchedTimes_tbl.Properties.UserData = meta_data;

end

function matchedTimes_tbl = addIntermidiateTimes(vidTimesVec, matchedTimes_tbl, i, iNext)
    % Add the intermidiate times
    Video_t = vidTimesVec(matchedTimes_tbl.Frame_n(i)+1:matchedTimes_tbl.Frame_n(iNext)-1)';
    Frame_n = (matchedTimes_tbl.Frame_n(i)+1:matchedTimes_tbl.Frame_n(iNext)-1)';
    Event_Type = {};
    [Event_Type{1:length(Video_t),1}] = deal('middle');
    % write zeroes in the observer column in intermidiate times
    tbl_add = [array2table(zeros(length(Video_t),1), 'VariableNames',{'Observer_t'})...
        array2table(Video_t) array2table(Frame_n) array2table(Event_Type) array2table(zeros(length(Video_t),1), 'VariableNames',{'Error'})];

    if ~isempty(tbl_add)
        matchedTimes_tbl = [matchedTimes_tbl; tbl_add];
    end
end

function AU_matchedTimes_tbl = filterRows(matchedTimes_tbl)
    % Filter the rows
    AU_matchedTimes_tbl = sortrows(matchedTimes_tbl, 'Frame_n');

    % Find repetitions (when "point" falls on middle/start/stop) and make it
    % one row
    uniqueFrames          = unique(AU_matchedTimes_tbl.Frame_n);
    uniqueInd             = find(hist(AU_matchedTimes_tbl.Frame_n, uniqueFrames)>1);
    repeatedValues        = uniqueFrames(uniqueInd);

    pointRowInds = [];
    middleRowInds = [];
    middleObservTimes = [];
    for i = 1:length(repeatedValues)
        ind = find(AU_matchedTimes_tbl.Frame_n == repeatedValues(i));
        pointLocalInd = find(strcmp('Point',AU_matchedTimes_tbl.Event_Type(ind)));
        pointInd = (ind(pointLocalInd));
        pointRowInds = [pointRowInds; pointInd];
        
        % add the time from "point" event to the "middle"
        middleLocalInd = find(strcmp('middle',AU_matchedTimes_tbl.Event_Type(ind)));
        if ~isempty(middleLocalInd)
            middleInd = (ind(middleLocalInd));
            AU_matchedTimes_tbl.Observer_t(middleInd) = AU_matchedTimes_tbl.Observer_t(pointInd(1));
        end
    end
        
    % delete the duplicate rows (point events)
    AU_matchedTimes_tbl(pointRowInds, :) = [];
    [~, pntFrameInds ,~] = intersect(AU_matchedTimes_tbl.Frame_n, repeatedValues);

    AU_matchedTimes_tbl.isPointEvent = zeros(height(AU_matchedTimes_tbl), 1);
    AU_matchedTimes_tbl.isPointEvent(pntFrameInds) = 1;
end