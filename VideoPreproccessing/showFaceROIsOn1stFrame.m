function showFaceROIsOn1stFrame(inputVid, rectCellArray)

if ~exist(inputVid, 'file')
	fprintf('File not found:\n%s\n', inputVid);
    return;
end

vr = VideoReader(inputVid);

if hasFrame(vr)
    vidFrame = readFrame(vr);

    imgWROIs = diplayROIs(vidFrame, rectCellArray);
    
    figure; 
    imshow(imgWROIs);
    
    [~, vidName, ~] = fileparts(inputVid);
    titleStr = sprintf('Defined face ROIs of %s', vidName);
    title(titleStr);
end
