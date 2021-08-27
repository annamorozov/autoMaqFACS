function img = reshapeAndShowImg(vecToRehape, w, h, titleStr, isShow)

    if nargin < 5 
        isShow = true;              % threshold for eigenvalies
    end   
    
    if (w ~= 0 && h ~= 0)
        img_vec = reshape(vecToRehape, [w,h]);
    end
    
    if isShow
        figure
        imagesc(img_vec',[0 255]); colormap(gray);
        title(titleStr);
    end
    
    img = img_vec';
end