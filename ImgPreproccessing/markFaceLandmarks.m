function landmarkPts = markFaceLandmarks(img)
% Mark 7 landmark points on an image

h1 = figure; imshow(img);
title('Mark the corners of the eyes (only 2 points in each eye, from left to right) and press Enter (Backspace/Delete to delete):');
[xEyes, yEyes] = getpts;
fprintf('\n');

h2 = figure; imshow(img);
title('Mark the corners of the mouth (2 pnts) and center of the mouth point between 2 lips (1 pnt), and press Enter (Backspace/Delete to delete):');
[xMouth, yMouth] = getpts;
fprintf('\n');

landmarkPts = [[xEyes; xMouth], [yEyes; yMouth]];

close(h1);
close(h2);

