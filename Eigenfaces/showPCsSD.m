function showPCsSD(sdNum, pcNum, eigVectors, meanWeights, stdWeights, Psi_train, w, h, isNormalize)
% Adding mean PCs to the mean img and varying SD.

if nargin < 9   % no isNormalize
    isNormalize = false;
end
    

up_lim_i = sdNum;
plots_num = up_lim_i*2+1;

nPcTot = size(eigVectors, 2); 
jEnd = min(nPcTot, pcNum);

for j = 1:jEnd                                 % Iteration over PCs
    figure
    colormap(gray)
    plot_h=ceil(sqrt(plots_num)); plot_w=ceil(sqrt(plots_num));
    for i= -1*up_lim_i : up_lim_i               % Iteration over SDs
      subplot(plot_h,plot_w,i+up_lim_i+1)
      sd_w_pc_j = meanWeights(j)+i*stdWeights(j);
      sd_v_pc_j = sd_w_pc_j*eigVectors(:,j)';

      % now add the mean back:
      sd_pc_j_full = sd_v_pc_j + Psi_train';
      im_sd_pc_j_full = reshape(sd_pc_j_full, [w,h]);
      
      if isNormalize
          norm_vec = im_sd_pc_j_full - min(im_sd_pc_j_full(:)); 
          norm_vec = norm_vec ./ max(norm_vec(:));
          imagesc(norm_vec');
      else
          imagesc(im_sd_pc_j_full',[0 255]); colormap(gray);
      end
      
      axis off
      str = sprintf('PC %d: %d SD',j, i);
      title(str);
    end
end

end