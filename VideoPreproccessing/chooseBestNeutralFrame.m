function frameNum = chooseBestNeutralFrame(inputVid)
% Choose the "best" neutral frame in a video 

% Important: the name of the video must not:
% 1. Begin with number
% 2. Include signs except letters, numbers and '_'

frameRate = 5; 
[~,vidName,~] = fileparts(inputVid);

% get the Video Viewer app handle and wait until it is closed
% (important: it must be the only open window at this point)
appHandle = implay(inputVid, frameRate);
title = 'Stop at the desired frame, press "Export to Image Tool" and close the Video Viewer App:';
set(appHandle.Parent, 'Name', title);
waitfor(appHandle);

% get the imtool figure
allGraphObj = findall(0);
imtoolFig = findall(allGraphObj, 'Tag', 'imtool');
figName = imtoolFig.Name;

% extract the frame number from image tool title
validName = matlab.lang.makeValidName(vidName);    % The app changes the title to valid name
expression = sprintf('%s_(\\d*)$',validName);
matched = regexp(figName,expression,'tokens');
frameNum = str2double(matched{:});


imtool close all;


