function outputVideoName = editVideo(inputVideo, outputFolder, varargin)
% editVideo  - edit a video: convert format/ scale/ cut/ zero pad
%   Optional args: 'outputFormat', 'scale', 'startFrame', 'endFrame',
%   padRows, padCols, outVidName, isArchival

%% Parse the input

minArgs=4;
maxArgs=18;
narginchk(minArgs,maxArgs)

p = inputParser;

defaultOutputFormat = 'avi';
checkOutputFormat = @(x) any(ismember({VideoReader.getFileFormats().Extension},x));
checkNaturalN = @(x) ismember(x,1:max(x));  % Natural number check
 
defaultScale      = 1;
defaultStartFrame = 1;        
defaultEndFrame   = -1;       %The whole video
defaultPadRows    = 0;
defaultPadCols    = 0;
defaultIsArchival = false;

% Construct output name
[~, inputVideoName, ~] = fileparts(inputVideo);
outputVideoName = fullfile(outputFolder,inputVideoName);
defaultOutVidName = outputVideoName;

addRequired(p,'inputVideo',@ischar);
addRequired(p,'outputFolder',@ischar);

addParameter(p,'outputFormat',defaultOutputFormat,checkOutputFormat);
addParameter(p,'scale',defaultScale,@any);
addParameter(p,'startFrame',defaultStartFrame,checkNaturalN);
addParameter(p,'endFrame',defaultEndFrame,checkNaturalN);
addParameter(p,'padRows',defaultPadRows,checkNaturalN);
addParameter(p,'padCols',defaultPadCols,checkNaturalN);
addParameter(p,'outVidName',defaultOutVidName,@ischar);
addParameter(p,'isArchival',defaultIsArchival,@islogical);

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


if ~ismember('outVidName', p.UsingDefaults)
    outputVideoName = p.Results.outVidName;
else
    if ~ismember('scale', p.UsingDefaults)
        outputVideoName = sprintf('%s_x_%2.2f', outputVideoName, p.Results.scale);
    end

    if ~ismember('startFrame', p.UsingDefaults) || ~ismember('endFrame', p.UsingDefaults) 
        outputVideoName = sprintf('%s_fr_%d-%d', outputVideoName, p.Results.startFrame, p.Results.endFrame);
    end

    if ~ismember('padRows', p.UsingDefaults) || ~ismember('padCols', p.UsingDefaults) 
        outputVideoName = sprintf('%s_padR_%d_padC_%d', outputVideoName, p.Results.padRows, p.Results.padCols);
    end

    outputVideoName = sprintf('%s.%s', outputVideoName, p.Results.outputFormat);
end

%% Video processing

vr = VideoReader(inputVideo);

if p.Results.isArchival
    vw = VideoWriter(outputVideoName, 'Archival');
else
    vw = VideoWriter(outputVideoName);
end
open(vw);

frameIndx = 1;

while hasFrame(vr) 
    % Extract the frame from the movie structure
    vidFrame = readFrame(vr);
    
    if frameIndx >= p.Results.startFrame      
        if ~ismember('endFrame', p.UsingDefaults)
            if frameIndx > p.Results.endFrame
                break;
            end
        end
        
        if ~ismember('padRows', p.UsingDefaults) || ~ismember('padCols', p.UsingDefaults) 
            vidFrame = padarray(vidFrame,[p.Results.padCols p.Results.padRows],'both');
        end

        if ~ismember('scale', p.UsingDefaults)
            vidFrame = imresize(vidFrame, p.Results.scale);
        end
   
        writeVideo(vw, vidFrame);
    end
 
    frameIndx = frameIndx + 1;
end

close(vw);

fprintf('editVideo: %d frames were successfully written to %s\n', frameIndx-1, outputVideoName);

end

    
