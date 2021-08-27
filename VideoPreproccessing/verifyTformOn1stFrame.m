function bApproved = verifyTformOn1stFrame(inputVid, tform, outputView)
% Show the transformation on the first frame and prompt for approval

if ~exist(inputVid, 'file')
	fprintf('File not found:\n%s\n', inputVid);
    return;
end

bApproved = false;
vr = VideoReader(inputVid);

if hasFrame(vr)
    vidFrame = readFrame(vr);

    alignedFrame = imwarp(vidFrame,tform,'OutputView',outputView);
    
    figure; 
    imshow(alignedFrame);

    answer = questdlg('Do you approve the alignment transformation?', ...
        'Transformation Approval', ...
        'Yes','No', 'Yes');

    % Handle response
    switch answer
        case 'Yes'
            fprintf('Alignment transformation approved.');
            bApproved = true;
        case 'No'
            fprintf('Facial landmarks for %s should be redefined.', inputVid);
            bApproved = false;
            
            return;
    end
end
