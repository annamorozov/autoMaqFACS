function [corrMat, fig] = createAUsCorrMat(AUsInFramesTbl, labelsList, isShow, vidName, colNames) 
% Create correlation matrix for AUs

% vidName - optional param. The name of the video for the title. 

if nargin < 5 || isempty(colNames)   % colNames
    colNames = AUsInFramesTbl.Properties.VariableNames(2:end);
end

mat = AUsInFramesTbl{:,colNames};  % First column is frames ind.
[corrMat, pval] = corr(mat);

fig = [];

if isShow
    fig = figure;
    imagesc(corrMat); % plot the matrix

    n = length(labelsList); % to handle '_' as a regular char and not subscript
    set(gca,'TickLabelInterpreter','none');
    set(gca, 'XTick', 1:n); % center x-axis ticks on bins
    set(gca, 'YTick', 1:n); % center y-axis ticks on bins
    set(gca, 'XTickLabel', labelsList); % set x-axis labels
    set(gca, 'YTickLabel', labelsList); % set y-axis labels

    titleStr = 'AUs correlation matrix';
    if nargin > 3 || ~isempty(vidName)
        titleStr = sprintf('AUs correlation matrix of video %s', vidName);
    end
    title(titleStr, 'FontSize', 14, 'Interpreter', 'none'); % set title

    colormap('jet'); % set the colorscheme
    colorbar  % enable colorbar
end