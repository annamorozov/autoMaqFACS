function saveAllFigures(baseFolderName, isSavePng)

if nargin == 1   % isSavePng
    isSavePng = false;
end

outputFolder = sprintf('%s/Figures', baseFolderName);
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

h = get(0,'children');
for i=1:length(h)
  fileName = sprintf('%s/%s', outputFolder, num2str(get(h(i),'Number'))');
  saveas(h(i), fileName, 'fig');
  
  if isSavePng 
      saveas(h(i), fileName, 'png');
  end
end

fprintf('Successfully saved %d figures.\n', length(h));

end