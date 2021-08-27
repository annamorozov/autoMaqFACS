function [closestInd, isPrev] = getClosestNeutralFrameInd(currentFrameInd, neutralFramesInd)

% Returns the closest neutral frame to the given current frame. If the
% given frame is neutral itself, the function returns another closest
% neutral frame (which is not the given one).

isPrev = true;
closestInd = 0;

lastPrevNeutr = -inf;
firstNextNeutr = inf;


prevNeutral = find(neutralFramesInd < currentFrameInd);
if ~isempty(prevNeutral)
    lastPrevNeutr = neutralFramesInd(prevNeutral(end));
else
    fprintf('For frame %d there are no neutral frames before.\n', currentFrameInd);
end

nextNeutr = find(neutralFramesInd > currentFrameInd);
if ~isempty(nextNeutr)
    firstNextNeutr = neutralFramesInd(nextNeutr(1));
else
    fprintf('For frame %d there are no neutral frames after.\n', currentFrameInd);
end

if (currentFrameInd - lastPrevNeutr) <= (firstNextNeutr - currentFrameInd)
    closestInd = lastPrevNeutr;
else
    closestInd = firstNextNeutr;
    isPrev = false;
end

if isempty(closestInd)
    closestInd = 0;
    fprintf('The closest neutral frame to frame %d was not found.\n', currentFrameInd);
end


