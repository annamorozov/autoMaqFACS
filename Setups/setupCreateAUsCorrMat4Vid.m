function setupCreateAUsCorrMat4Vid(AUsFramesTblsFileCol, AusAnalysisDirCol, ...
    isShow, vidName4Corr, ROItype, ROIsAUsFramesTblsFileCol)

% The function creates and saves AUs correlation matrix and its figure
% for each video.
% The function also creates table of AUs in frames for each video and the
% neutral frames for ROI, and appends them to the [AUsFramesTblsFileCol{i}] mat file.
% The figure is saved if isShow == 1.

% ROItype - optional param:
% 1 = upper face
% 2 = lower face

for i = 1:length(AUsFramesTblsFileCol)
    load(AUsFramesTblsFileCol{i}, 'AUs_summary_tbl', 'training_matchedTimes_tbl');
    
    if nargin > 4   % ROI
        AUs_summary_tbl = getROI_AUs_summary_tbl(AUs_summary_tbl, ROItype);
        
        if isempty(AUs_summary_tbl)
             fprintf('For video %s there were no AUs of ROI type %d .\n', vidName4Corr{i}, ROItype);
            continue;
        end
    end
    
    framesNums = getAllFramesNums(AUs_summary_tbl);
    AUsInFramesTbl = getAUsInFramesTbl(framesNums, AUs_summary_tbl);
    
    if nargin > 4   % ROI
        % Find the neutral frames for the ROI
        vidLength_fr = training_matchedTimes_tbl.Frame_n(end);
        neutralFrames_trainVid_ROI_logic = ~ismember(1:vidLength_fr, AUsInFramesTbl.frameNum);
        neutralFrames_trainVid_ROI = find(neutralFrames_trainVid_ROI_logic);
        
        if ismember('lastFrForNeutralFr', training_matchedTimes_tbl.Properties.VariableNames)
            if ~isempty(training_matchedTimes_tbl.lastFrForNeutralFr(1))
                    lastFrForNeutr = training_matchedTimes_tbl.lastFrForNeutralFr(1);

                    if lastFrForNeutr <= training_matchedTimes_tbl.Frame_n(end)

                        neutralFrames_trainVid_ROI = neutralFrames_trainVid_ROI(neutralFrames_trainVid_ROI <= lastFrForNeutr);
                    end
            end
        end
    end
    
    % The number nLabeledFrames doesn't include neutral frames.
    nLabeledFrames = size(AUsInFramesTbl, 1);
    
    labelsList = AUs_summary_tbl{{'OrigPtrn'}, :};
    [AUsCorrMat, fig] = createAUsCorrMat(AUsInFramesTbl, labelsList, isShow, vidName4Corr{i}); 
    
    saveDir = AusAnalysisDirCol{i};
    if ~exist(saveDir, 'dir')
        mkdir(saveDir);
    end
    
    if nargin > 4   % ROI
        save(ROIsAUsFramesTblsFileCol{i}, 'AUsInFramesTbl', 'nLabeledFrames', 'neutralFrames_trainVid_ROI');
    else
        save(AUsFramesTblsFileCol{i}, 'AUsInFramesTbl', 'nLabeledFrames', '-append');
    end
    
    save(fullfile(saveDir, 'AUsCorrMat.mat'), 'AUsCorrMat');
    
    if isShow
        saveas(fig, fullfile(saveDir, 'AUsCorrMat.fig'));
    end
end

