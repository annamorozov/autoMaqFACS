function [ROIsPosition, BWmasks, totMask] = defineFaceRegionsROIs(faceImg)

% Function to define rectangular face ROIs: upper face, lower face and 2
% ears

figure;
imshow(faceImg);

sz = size(faceImg);
totMask = false(sz); % accumulate all single object masks to this one

ROIsPosition = {}; 
BWmasks = {};
nRegions = 4;

regionNames = {'upper face'; 'lower face'; 'left ear'; 'right ear'};

for i = 1:nRegions
      % ask user for another mask
      str = sprintf('Draw the [%s] ROI rectangle and double click to approve. %d/%d ROIs defined', regionNames{i}, i-1, nRegions);
      title(str);

      h = imrect( gca ); setColor(h,'red');
      
      ROIsPosition{i} = wait( h );
      BWmasks{i} = createMask( h );
      totMask = totMask | BWmasks{i}; % add mask to global mask
end

% show the resulting mask
% figure; 
% imshow(totMask); 
% title('All face regions mask');
% 
% maskedImg = applyImgMask(faceImg, totMask);
% figure; 
% imshow(maskedImg); 
% title('Masked img');