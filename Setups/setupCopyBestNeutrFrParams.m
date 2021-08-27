function setupCopyBestNeutrFrParams(sourceAUsFramesTblsFileCol, targetAUsFramesTblsFileCol)

for i = 1:length(sourceAUsFramesTblsFileCol)
    copyBestNeutrFrParams(sourceAUsFramesTblsFileCol{i}, targetAUsFramesTblsFileCol{i});
end
