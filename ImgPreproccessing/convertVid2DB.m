function [Images,w,h] = convertVid2DB(inputVideo, outputFolder, varargin)
% Create database from a video

% Optional params: 'imgBuffer', 'downscaleF'
% Example: 
% convertVid2DB(inputVideo, outputFolder, 'imgBuffer', 500, 'downscaleF', 4);

%% Parse the input

minArgs=1;
maxArgs=6;
narginchk(minArgs,maxArgs);

p = inputParser;

defaultImgBuffer = 500;
defaultScale = 1.0;

checkImgBufferFormat = @(x) (isnumeric(x) && ismember(x,1:x));    
checkScaleFormat = @(x) (isreal(x) && x>0);

addRequired(p,'inputVideo',@ischar);
addRequired(p,'outputFolder',@ischar);

addParameter(p,'imgBuffer',defaultImgBuffer,checkImgBufferFormat);
addParameter(p,'scale',defaultScale,checkScaleFormat);

parse(p,inputVideo,outputFolder,varargin{:});

disp(['Input video file: ',p.Results.inputVideo]);
disp(['Output folder: ', p.Results.outputFolder]);

if ~isempty(p.UsingDefaults)
   disp('Using defaults: ');
   disp(p.UsingDefaults);
end

%% Setup
if ~exist(inputVideo, 'file')
	fprintf('File not found:\n%s\n', inputVideo);
    return;
end

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

[~,vidName,~] = fileparts(inputVideo);

Images = [];
db_indx = 1;
old_w = 0;
old_h = 0;
w=0;
h=0;

vr = VideoReader(inputVideo);

nFramesEst = ceil(vr.FrameRate*vr.Duration);
imgBuffer = p.Results.imgBuffer;
scale = p.Results.scale;

if (imgBuffer > nFramesEst) 
    if ~ismember('imgBuffer', p.UsingDefaults)
        fprintf('convertVid2DB: imgBuffer %d can not be larger than number of images %d. Changed imgBuffer to %d.\n', p.Results.img_buffer, nFramesEst, nFramesEst);
    end
    img_buffer = nFramesEst;
end

%% Processing

imgSizePath = sprintf('%s/imageSize.mat',outputFolder);
nFrames = 1;

% Get the images
fprintf('convertVid2DB: Going to convert the video %s to matrix DB\n', inputVideo);
   
while hasFrame(vr)     
    Img_full = readFrame(vr);

    % Convert to gray (if not gray)
    nChannels = size(Img_full,3);
    if nChannels ~= 1
        Img = rgb2gray(Img_full);
    else
        Img = Img_full;
    end
        
    if nFrames == 1                         % If this is first image, figure things out
        old_w = size(Img,2);                % Just an initialization
        old_h = size(Img,1);
        
        if scale == 1.0
            w = old_w; h = old_h;
            Images = zeros(w*h,imgBuffer);  % - preallocate size of the return matrix
            save(imgSizePath, 'w', 'h');
        end
    end % nFrames == 1
    
    if scale ~= 1.0
        Img = imresize(Img, scale);         % Do the scale
        
        if (nFrames == 1)
            [h, w, ~] = size(Img);          % Update the new height and weights in the beginning
            save(imgSizePath, 'w', 'h');
        end
    end % scale ~= 1.0
    
    % Find the index in Images
    img_indx = mod(nFrames, imgBuffer);
    if(img_indx == 0)
        img_indx = imgBuffer;
    end
    
    Images(1:w*h,img_indx) = reshape(Img',w*h,1);   % Make a column vector and add it to the output matrix
    fprintf('convertVid2DB: Converted %d images...\n', nFrames);
    
    if (mod(nFrames,imgBuffer) == 0)                % We reached a full cycle of img_buffer
        saveDB(outputFolder, db_indx, Images);
        
        if (nFrames < nFramesEst)                   % This is not end of images
            if (nFrames + imgBuffer > nFramesEst)   % Next chunk is the last
                chunk_size = imgBuffer - mod(nFramesEst, imgBuffer);
            else
                chunk_size = imgBuffer;
            end
            
            Images = zeros(w*h, chunk_size);         % - preallocate size of the return matrix
            db_indx = db_indx + 1;
        end
    elseif (nFrames == nFramesEst)                   % this means also (mod(i,img_buffer) ~= 0)
        saveDB(outputFolder, db_indx, Images);
    end
    
    nFrames = nFrames + 1;
    
end

fprintf(1,'Sucessfully converted and saved to DB %d images.\n', nFrames - 1);

end

function saveDB(outputFolder, db_indx, Images)
        db_name = sprintf('%s/imagesDB_%d.mat', outputFolder, db_indx);
        save(db_name, 'Images');
        fprintf(1,'%s successfully saved.\n', db_name);
end