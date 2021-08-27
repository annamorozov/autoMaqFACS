function fullSetupAllSubj_AUsProc_Increment(procDataDir_allSubj, subjNames, sectionsToSkip)
% Explore and analyse the AUs (in labeled videos) - frequencies, correlations etc...

% sectionsToSkip - optional param: may be specified to skip running of
%                  code sections.

if nargin < 3   % sectionsToSkip
    sectionsToSkip = [];
end

%% AU analysis
isShow = true;  

%% Section 1: histograms AU analysis for ***UPPER FACE*** ROIs
if ~ismember(1, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 

        subjUpperAuSumDir = wholeSubjPath.AUsUpperFaceAnalysisDir;
        ROItype = 1;    % UPPER FACE

        setupMakeAUsFreqHistograms(pathTbl.AUsFramesTblsFile, pathTbl.AusAnalysisDir,...
            pathTbl.Properties.RowNames, ROItype);

        setupSumAUsFreqTbls(subjUpperAuSumDir, pathTbl.AUsFramesTblsFile, ROItype);
        setupSumAUsFreqHistograms(subjUpperAuSumDir);

        % AUs ****UPPER FACE GROUPS**** (AU combinations) histograms analysis:
        groupSize = 2; %%%%%%%%%%%%%%%%%

        % Per video
        setupMakeAUsGroupsFreqTbls(pathTbl.AUsFramesTblsFile, pathTbl.upperFaceAusAnalysisDir, groupSize, ROItype);
        setupMakeAUsGroupsHistograms(pathTbl.upperFaceAusAnalysisDir, groupSize, pathTbl.Properties.RowNames, 1);

        % All videos per subject
        setupSumAUsGroupsFreqTbls(pathTbl.upperFaceAusAnalysisDir, subjUpperAuSumDir, groupSize);
        setupSumAUsGroupsHistograms(subjUpperAuSumDir, groupSize);

        groupSize = 3;%%%%%%%%%%%%%%%%%%

        % Per video
        setupMakeAUsGroupsFreqTbls(pathTbl.AUsFramesTblsFile, pathTbl.upperFaceAusAnalysisDir, groupSize, ROItype);
        setupMakeAUsGroupsHistograms(pathTbl.upperFaceAusAnalysisDir, groupSize, pathTbl.Properties.RowNames, 1);

        % All videos per subject
        setupSumAUsGroupsFreqTbls(pathTbl.upperFaceAusAnalysisDir, subjUpperAuSumDir, groupSize);
        setupSumAUsGroupsHistograms(subjUpperAuSumDir, groupSize);

        close all;
    end
end

%% Section 2: corr matrix for ***UPPER FACE***
if ~ismember(2, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        
        subjUpperAuSumDir = wholeSubjPath.AUsUpperFaceAnalysisDir;
        ROItype = 1;    % UPPER FACE

        % Corr matrix of ***UPPER FACE AUs***:
        % Per video
        fprintf('Creating upper face AUsCorrMat for subject %s \n', subjNames{i});
        
        setupCreateAUsCorrMat4Vid(pathTbl.AUsFramesTblsFile, pathTbl.upperFaceAusAnalysisDir, isShow,...
            pathTbl.Properties.RowNames, ROItype, pathTbl.upperFaceAUsFramesTblsFile);
        
        % All videos per subject
        setupSumAUsCorrMats(pathTbl.upperFaceAUsFramesTblsFile, subjUpperAuSumDir, isShow);

        close all;
    end
end

%% Section 3: histograms AU analysis for ***LOWER FACE*** ROIs

if ~ismember(3, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 

        subjLowerAuSumDir = wholeSubjPath.AUsLowerFaceAnalysisDir;
        ROItype = 2;    % LOWER FACE

        setupMakeAUsFreqHistograms(pathTbl.AUsFramesTblsFile, pathTbl.AusAnalysisDir,...
            pathTbl.Properties.RowNames, ROItype);

        setupSumAUsFreqTbls(subjLowerAuSumDir, pathTbl.AUsFramesTblsFile, ROItype);
        setupSumAUsFreqHistograms(subjLowerAuSumDir);

        % AUs ****LOWER FACE groups**** (AU combinations) histograms analysis:
        groupSize = 2; %%%%%%%%%%%%%%%%%

        % Per video
        setupMakeAUsGroupsFreqTbls(pathTbl.AUsFramesTblsFile, pathTbl.lowerFaceAusAnalysisDir, groupSize, ROItype);
        setupMakeAUsGroupsHistograms(pathTbl.lowerFaceAusAnalysisDir, groupSize, pathTbl.Properties.RowNames, 1);

        % All videos per subject
        setupSumAUsGroupsFreqTbls(pathTbl.lowerFaceAusAnalysisDir, subjLowerAuSumDir, groupSize);
        setupSumAUsGroupsHistograms(subjLowerAuSumDir, groupSize);

        groupSize = 3;%%%%%%%%%%%%%%%%%%

        % Per video
        setupMakeAUsGroupsFreqTbls(pathTbl.AUsFramesTblsFile, pathTbl.lowerFaceAusAnalysisDir, groupSize, ROItype);
        setupMakeAUsGroupsHistograms(pathTbl.lowerFaceAusAnalysisDir, groupSize, pathTbl.Properties.RowNames, 1);

        % All videos per subject
        setupSumAUsGroupsFreqTbls(pathTbl.lowerFaceAusAnalysisDir, subjLowerAuSumDir, groupSize);
        setupSumAUsGroupsHistograms(subjLowerAuSumDir, groupSize);

        close all;
    end
end


%% Section 4: corr matrix for ***LOWER FACE***
if ~ismember(4, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 

        subjLowerAuSumDir = wholeSubjPath.AUsLowerFaceAnalysisDir;
        ROItype = 2;    % LOWER FACE
        
        % Corr matrix of ***LOWER FACE AUs***:
        % Per video
        fprintf('Creating lower face AUsCorrMat for subject %s \n', subjNames{i});

        setupCreateAUsCorrMat4Vid(pathTbl.AUsFramesTblsFile, pathTbl.lowerFaceAusAnalysisDir, isShow,...
            pathTbl.Properties.RowNames, ROItype, pathTbl.lowerFaceAUsFramesTblsFile);
        % All videos per subject
        setupSumAUsCorrMats(pathTbl.lowerFaceAUsFramesTblsFile, subjLowerAuSumDir, isShow);

        close all;
    end
end

%% Section 5: histograms AU analysis for the ***WHOLE FACE***
if ~ismember(5, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 

        subjAuSumDir = wholeSubjPath.AUsAnalysisDir;

        setupMakeAUsFreqHistograms(pathTbl.AUsFramesTblsFile, pathTbl.AusAnalysisDir,...
            pathTbl.Properties.RowNames);

        setupSumAUsFreqTbls(subjAuSumDir, pathTbl.AUsFramesTblsFile);
        setupSumAUsFreqHistograms(subjAuSumDir);

        % AUs groups ***WHOLE FACE*** (AU combinations) histograms analysis
        groupSize = 2;%%%%%%%%%%%%%%%%%%%%%%%%

        % Per video
        setupMakeAUsGroupsFreqTbls(pathTbl.AUsFramesTblsFile, pathTbl.AusAnalysisDir, groupSize);
        setupMakeAUsGroupsHistograms(pathTbl.AusAnalysisDir, groupSize, pathTbl.Properties.RowNames, 1);

        % All videos per subject
        setupSumAUsGroupsFreqTbls(pathTbl.AusAnalysisDir, subjAuSumDir, groupSize);
        setupSumAUsGroupsHistograms(subjAuSumDir, groupSize);

        groupSize = 3;%%%%%%%%%%%%%%%%%%%%%%%%

        % Per video
        setupMakeAUsGroupsFreqTbls(pathTbl.AUsFramesTblsFile, pathTbl.AusAnalysisDir, groupSize);
        setupMakeAUsGroupsHistograms(pathTbl.AusAnalysisDir, groupSize, pathTbl.Properties.RowNames, 1);

        % All videos per subject
        setupSumAUsGroupsFreqTbls(pathTbl.AusAnalysisDir, subjAuSumDir, groupSize);
        setupSumAUsGroupsHistograms(subjAuSumDir, groupSize);

        close all;
    end
end

%% Section 6: Corr matrix of ***WHOLE FACE*** AUs:
if ~ismember(6, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 

        % Corr matrix of ***WHOLE FACE*** AUs:

        % Per video
        setupCreateAUsCorrMat4Vid(pathTbl.AUsFramesTblsFile, pathTbl.AusAnalysisDir, isShow, pathTbl.Properties.RowNames);
        % All videos per subject
        subjAuSumDir = wholeSubjPath.AUsAnalysisDir;
        setupSumAUsCorrMats(pathTbl.AUsFramesTblsFile, subjAuSumDir, isShow);

        close all;
    end
end

%% Section 7: Summary of ***UPPER FACE*** frequencies, ALL SUBJECTS
% Helps to decide which subjects and AUs are going to be in the training
% Make a table summing all the AUs frequencies per subject

if ~ismember(7, sectionsToSkip)
    catUpperFreqTblsPath = {};
    for i = 1:length(subjNames)
        [~, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catUpperFreqTblsPath = [catUpperFreqTblsPath; wholeSubjPath.AUsUpperFaceAnalysisDir];
    end

    bAddRowSubjName = true;
    catSubjSumAuFreqTbls = catSubjAuFreqTbls(catUpperFreqTblsPath, bAddRowSubjName);

    % For example, sort according to AU1+2
    sortedUpperFreqTbl_allSubj = sortrows(catSubjSumAuFreqTbls,{'AU_1_2'}, 'descend');
    save(fullfile(procDataDir_allSubj, 'sortedUpperFreqTbl_allSubj.mat'), 'sortedUpperFreqTbl_allSubj');
end

% See the upper face result. 
% Choose with which data to work (which monkeys and AUs).

%% Section 8: Summary of ***UPPER FACE*** frequencies, PER SUBJECT
% Upper face frequencies for each subject, sorted by videos:

if ~ismember(8, sectionsToSkip)
    bAddRowSubjName = true;
    ROItype = 1;
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        upperFreqTbl_allVidsPerSubj = catSingleSubjAuFreqTbls(pathTbl.AUsFramesTblsFile, bAddRowSubjName, ROItype);
        % For example, sort according to AU1+2
        sortedUpperFreqTbl_allVidsPerSubj = sortrows(upperFreqTbl_allVidsPerSubj,{'AU_1_2'}, 'descend');
        save(fullfile(wholeSubjPath.AUsUpperFaceAnalysisDir, 'sortedUpperFreqTbl_allVidsPerSubj.mat'), 'sortedUpperFreqTbl_allVidsPerSubj');
    end
end

%% Section 9: Summary of ***LOWER FACE*** frequencies, ALL SUBJECTS
% Helps to decide which subjects and AUs are going to be in the training [lower face]

if ~ismember(9, sectionsToSkip)
    catLowerFreqTblsPath = {};
    for i = 1:length(subjNames)
        [~, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catLowerFreqTblsPath = [catLowerFreqTblsPath; wholeSubjPath.AUsLowerFaceAnalysisDir];
    end

    bAddRowSubjName = true;
    catSubjSumAuFreqTbls = catSubjAuFreqTbls(catLowerFreqTblsPath, bAddRowSubjName);

    %save(fullfile(procDataDir_allSubj, 'catSubjSumAuFreqTbls.mat'), 'catSubjSumAuFreqTbls');
    
    % For example, sort according to AU16 and AU18i
    sortedLowerFreqTbl_allSubj = sortrows(catSubjSumAuFreqTbls,{'AU_16', 'AU_18i'}, 'descend');
    save(fullfile(procDataDir_allSubj, 'sortedLowerFreqTbl_allSubj.mat'), 'sortedLowerFreqTbl_allSubj');
end

%% Section 10: Summary of ***LOWER FACE*** frequencies, PER SUBJECT
% Upper face frequencies for each subject, sorted by videos:

if ~ismember(10, sectionsToSkip)
    bAddRowSubjName = true;
    ROItype = 2;
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        lowerFreqTbl_allVidsPerSubj = catSingleSubjAuFreqTbls(pathTbl.AUsFramesTblsFile, bAddRowSubjName, ROItype);
        % For example, sort according to AU16 and AU18i
        sortedLowerFreqTbl_allVidsPerSubj = sortrows(lowerFreqTbl_allVidsPerSubj,{'AU_16', 'AU_18i'}, 'descend');
        save(fullfile(wholeSubjPath.AUsLowerFaceAnalysisDir, 'sortedLowerFreqTbl_allVidsPerSubj.mat'), 'sortedLowerFreqTbl_allVidsPerSubj');
    end
end

%% Section 11: Plot ***WHOLE FACE*** AUs flows (plot the events)
% Plot whole face AUs flows (events), including Neutral expression

if ~ismember(11, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupPlotVidAUsFlow(pathTbl.AusAnalysisDir, pathTbl.AUsFramesTblsFile,...
            pathTbl.AUsFramesTblsFile, pathTbl.Properties.RowNames);
        
        close all;
    end
end

%% Section 12: Plot ***UPPER FACE*** AUs flows
% Plot upper face AUs flows (events), including Neutral expression

if ~ismember(12, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupPlotVidAUsFlow(pathTbl.upperFaceAusAnalysisDir, pathTbl.AUsFramesTblsFile,...
            pathTbl.upperFaceAUsFramesTblsFile, pathTbl.Properties.RowNames);
        
        close all;
    end
end

%% Section 13: Plot ***LOWER FACE*** AUs flows
% Plot lower face AUs flows, including Neutral expression

if ~ismember(13, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupPlotVidAUsFlow(pathTbl.lowerFaceAusAnalysisDir, pathTbl.AUsFramesTblsFile,...
            pathTbl.lowerFaceAUsFramesTblsFile, pathTbl.Properties.RowNames);
        
        close all;
    end
end

%% Section 14: histograms AU analysis for ***UPPER FACE*** ROIs ***ALL SUBJECTS***
if ~ismember(14, sectionsToSkip)
    
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjUpperAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'upperAUsAnalysis');
    
    catUpperFreqTblsPath = {};
    catAUsFramesTblsFile = {};
    
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catUpperFreqTblsPath = [catUpperFreqTblsPath; wholeSubjPath.AUsUpperFaceAnalysisDir];
        
        catAUsFramesTblsFile = [catAUsFramesTblsFile; pathTbl.AUsFramesTblsFile];
    end
    
    ROItype = 1;
    setupSumAUsFreqTbls(allSubjUpperAuSumDir, catAUsFramesTblsFile, ROItype);
    setupSumAUsFreqHistograms(allSubjUpperAuSumDir);
    
    isSubjectsSum = true;
    
    % AU combinations
    groupSize = 2; 
    setupSumAUsGroupsFreqTbls(catUpperFreqTblsPath, allSubjUpperAuSumDir, groupSize, isSubjectsSum);
    setupSumAUsGroupsHistograms(allSubjUpperAuSumDir, groupSize, isSubjectsSum);
    
    groupSize = 3;
    setupSumAUsGroupsFreqTbls(catUpperFreqTblsPath, allSubjUpperAuSumDir, groupSize, isSubjectsSum);
    setupSumAUsGroupsHistograms(allSubjUpperAuSumDir, groupSize, isSubjectsSum);
end

%% Section 15: histograms AU analysis for ***LOWER FACE*** ROIs ***ALL SUBJECTS***
if ~ismember(15, sectionsToSkip)
    
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjLowerAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'lowerAUsAnalysis');
        
    catLowerFreqTblsPath = {};
    catAUsFramesTblsFile = {};
    
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catLowerFreqTblsPath = [catLowerFreqTblsPath; wholeSubjPath.AUsLowerFaceAnalysisDir];
        
        catAUsFramesTblsFile = [catAUsFramesTblsFile; pathTbl.AUsFramesTblsFile];
    end
    
    ROItype = 2;
    setupSumAUsFreqTbls(allSubjLowerAuSumDir, catAUsFramesTblsFile, ROItype);
    setupSumAUsFreqHistograms(allSubjLowerAuSumDir);
    
    
    isSubjectsSum = true;
    
    % AU combinations
    groupSize = 2;
    setupSumAUsGroupsFreqTbls(catLowerFreqTblsPath, allSubjLowerAuSumDir, groupSize, isSubjectsSum);
    setupSumAUsGroupsHistograms(allSubjLowerAuSumDir, groupSize, isSubjectsSum);
    
    groupSize = 3;
    setupSumAUsGroupsFreqTbls(catLowerFreqTblsPath, allSubjLowerAuSumDir, groupSize, isSubjectsSum);
    setupSumAUsGroupsHistograms(allSubjLowerAuSumDir, groupSize, isSubjectsSum);
end

%% Section 16: corr matrix for ***UPPER FACE*** for ***ALL SUBJECTS***
if ~ismember(16, sectionsToSkip)
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjUpperAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'upperAUsAnalysis');
    
    catUpperTblsPath = {}; 
    for i = 1:length(subjNames)
        [~, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catUpperTblsPath = [catUpperTblsPath; fullfile(wholeSubjPath.AUsUpperFaceAnalysisDir,'subjAUsInFramesTbl.mat')];
    end
    
    isSubjectsSum = true;
    isShow = true;
        
    setupSumAUsCorrMats(catUpperTblsPath, allSubjUpperAuSumDir, isShow, isSubjectsSum)
end

%% Section 17: corr matrix for ***LOWER FACE*** for ***ALL SUBJECTS***
if ~ismember(17, sectionsToSkip)
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjLowerAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'lowerAUsAnalysis');
    
    catLowerTblsPath = {}; 
    for i = 1:length(subjNames)
        [~, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catLowerTblsPath = [catLowerTblsPath; fullfile(wholeSubjPath.AUsLowerFaceAnalysisDir,'subjAUsInFramesTbl.mat')];
    end
    
    isSubjectsSum = true;
    isShow = true;
        
    setupSumAUsCorrMats(catLowerTblsPath, allSubjLowerAuSumDir, isShow, isSubjectsSum)
end

%% Section 18: corr matrix for ***WHOLE FACE*** for ***ALL SUBJECTS***
if ~ismember(18, sectionsToSkip)
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'AUsAnalysis');
    
    catTblsPath = {}; 
    for i = 1:length(subjNames)
        [~, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catTblsPath = [catTblsPath; fullfile(wholeSubjPath.AUsAnalysisDir,'subjAUsInFramesTbl.mat')];
    end
    
    isSubjectsSum = true;
    isShow = true;
        
    setupSumAUsCorrMats(catTblsPath, allSubjAuSumDir, isShow, isSubjectsSum)
end

%% Section 19: sum all subjects AUs frequency tables
if ~ismember(19, sectionsToSkip)
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'AUsAnalysis');

    subjAuSumDirCol = {};

    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 
        subjAuSumDir = wholeSubjPath.AUsAnalysisDir;

        subjAuSumDirCol = [subjAuSumDirCol; subjAuSumDir];
    end
    
    setupSumSubjAUsFreqTbls(allSubjAuSumDir, subjAuSumDirCol);
end

%% Section 20: sum all subjects training frames
if ~ismember(20, sectionsToSkip)
    allSubjDirName = strjoin(subjNames,'_');   % 'K_Q'
    allSubjAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'Meta');

    nTotTrainFrames_allSubj = 0;

    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i}); 
        subjAuSumDir = wholeSubjPath.AUsAnalysisDir;

        nTotTrainFrames_subj = setupSumTotTrainFramesPerSubj(pathTbl.AUsFramesTblsFile, wholeSubjPath.MetaDir);
        nTotTrainFrames_allSubj = nTotTrainFrames_allSubj + nTotTrainFrames_subj;
    end
    
    save(fullfile(allSubjAuSumDir,'nTotTrainFrames_allSubj.mat'), 'nTotTrainFrames_allSubj');
end

%% Section 21: corr matrix for ***WHOLE FACE*** for ***ALL SUBJECTS***
if ~ismember(21, sectionsToSkip)
    allSubjDirName = strjoin(subjNames,'_');   
    allSubjAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'AUsAnalysis');
    
    catTblsPath = {}; 
    for i = 1:length(subjNames)
        [~, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catTblsPath = [catTblsPath; fullfile(wholeSubjPath.AUsAnalysisDir,'subjAUsInFramesTbl.mat')];
    end
    
    isSubjectsSum = true;
    isShow = true;
    
    %colNames = {'AU_25', 'AU_26', 'AU_18i', 'AU_16', 'lowerNone', 'AU_1_2', 'AU_43_5', 'upperNone'};
    %setupSumAUsCorrMats(catTblsPath, allSubjAuSumDir, isShow, isSubjectsSum, colNames)
    
    setupSumAUsCorrMats(catTblsPath, allSubjAuSumDir, isShow, isSubjectsSum)

end

%% Section 22: histograms AU analysis for ***WHOLE FACE*** ROIs ***ALL SUBJECTS***
if ~ismember(22, sectionsToSkip)
    
    allSubjDirName = strjoin(subjNames,'_');  
    allSubjAuSumDir = fullfile(procDataDir_allSubj, allSubjDirName, 'AUsAnalysis');
    
    catFreqTblsPath = {};
    catAUsFramesTblsFile = {};
    
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        catFreqTblsPath = [catFreqTblsPath; wholeSubjPath.AUsAnalysisDir];
        
        catAUsFramesTblsFile = [catAUsFramesTblsFile; pathTbl.AUsFramesTblsFile];
    end
    
    setupSumAUsFreqTbls(allSubjAuSumDir, catAUsFramesTblsFile);
    setupSumAUsFreqHistograms(allSubjAuSumDir);
    
    isSubjectsSum = true;
    
    % AU combinations
    groupSize = 2;
    setupSumAUsGroupsFreqTbls(catFreqTblsPath, allSubjAuSumDir, groupSize, isSubjectsSum);
    setupSumAUsGroupsHistograms(allSubjAuSumDir, groupSize, isSubjectsSum);
    
    groupSize = 3;
    setupSumAUsGroupsFreqTbls(catFreqTblsPath, allSubjAuSumDir, groupSize, isSubjectsSum);
    setupSumAUsGroupsHistograms(allSubjAuSumDir, groupSize, isSubjectsSum);
end



