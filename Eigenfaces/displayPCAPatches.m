function displayPCAPatches(eigVectors, vecsNumToDisplay, maxVecNum,...
    w, h, imgContrastFuncName, isSeparatePlots)

% Display PCA patches

    if vecsNumToDisplay > maxVecNum
        vecsNumToDisplay = maxVecNum;
    end

    if nargin > 6 % isSeparatePlots
        if isSeparatePlots
            for i=1:vecsNumToDisplay
                figure
                colormap(gray)

                pcInd = i;
                if nargin > 5 % imgContrastFuncName
                    plotSinglePC(eigVectors, pcInd, w, h, imgContrastFuncName);
                else
                    plotSinglePC(eigVectors, pcInd, w, h);
                end
            end
        end
    else
        figure
        colormap(gray)
        plot_h=ceil(sqrt(vecsNumToDisplay)); 
        plot_w=ceil(sqrt(vecsNumToDisplay));
        
        for i=1:vecsNumToDisplay
            subplot(plot_h,plot_w,i)
            
            pcInd = i;
            if nargin > 5 % imgContrastFuncName
                plotSinglePC(eigVectors, pcInd, w, h, imgContrastFuncName);
            else
                plotSinglePC(eigVectors, pcInd, w, h);
            end
        end
    end

end

function plotSinglePC(eigVectors, pcInd, w, h, imgContrastFuncName)
  grayV = mat2gray(eigVectors(:,pcInd), [-1,1]);
  I = reshape(grayV,[w,h])';
  
  if nargin > 4 % imgContrastFuncName
    I = feval(imgContrastFuncName, I);
    title_i = sprintf('PC %d', pcInd);
  else
    title_i = sprintf('%d Original', pcInd);
  end
  
  imagesc(I, [min(min(I)) max(max(I))]);
  axis off
  title(title_i);
  colorbar
end