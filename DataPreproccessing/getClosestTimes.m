function matchedTimes_tbl = getClosestTimes(observerTimes, videoTimes, isAddTrainFrames, accuracy)

% videoTimes - the real values from the video
% observerTimes - the values from observer xls

if nargin < 4 
    accuracy = 0.0334;  % 1/(FrameRate = 29.9700)
end

observerTimeCol  = 1;
vidTimeCol       = 2;
vidFrameCol      = 3;
trainVidFrameCol = 4;

startVidFrame = 0;

matchedTimes = zeros(length(observerTimes), 3);

for i = 1:length(observerTimes)
    matchedTimes(i, observerTimeCol) = observerTimes(i);
    
    if observerTimes(i) == 0
        matchedTimes(i, vidTimeCol) = 0;
        matchedTimes(i, vidFrameCol) = 1;
        
        if isAddTrainFrames
            matchedTimes(i, trainVidFrameCol) = 0;
        end
    else
        tmp = abs(videoTimes-observerTimes(i));
        [dist, vec_indx] = min(tmp); %index of closest value
        
        if(dist > accuracy)
            fprintf('For observerTimes(%d) the distance (%d) is larger than accuracy (%d)\n', i, dist, accuracy);
        end
        
        matchedTimes(i, vidTimeCol) = videoTimes(vec_indx);
        matchedTimes(i, vidFrameCol) = vec_indx;
        
        if i == 1
            startVidFrame =  matchedTimes(i, vidFrameCol);
        end
        
        if isAddTrainFrames && startVidFrame ~= 0
            matchedTimes(i, trainVidFrameCol) = matchedTimes(i, vidFrameCol) - startVidFrame + 1;
        end
    end
end

matchedTimes_tbl = array2table(matchedTimes(:, 1:vidFrameCol), 'VariableNames',{'Observer_t', 'Video_t', 'Frame_n'});

if isAddTrainFrames
    matchedTimes_tbl = [matchedTimes_tbl array2table(matchedTimes(:, trainVidFrameCol), 'VariableNames',{'trainFrame_n'})];
end
