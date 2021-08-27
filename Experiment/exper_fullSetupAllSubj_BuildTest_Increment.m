function exper_fullSetupAllSubj_BuildTest_Increment(procDataDir_allSubj, subjNames,...
    globalAlignParamsDir, sectionsToSkip)
% Prepare the videos for validation and testing

if nargin < 4   % sectionsToSkip
    sectionsToSkip = [];
end

%% Section 1: Building testing videos
if ~ismember(1, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        % Prepare the testing vid
        isSavePreviewVid = true;
        exper_setupPrepareTestVideos(pathTbl, globalAlignParamsDir, isSavePreviewVid)
    end
end

%% Section 2: sanity check - neutral frames
%Create videos of neutral frames 
if ~ismember(2, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupValidateOrigNeutralCoding(pathTbl);
    end
end

%% Section 3: sanity check - different AUs
%Create videos of easy recognizable AUs for coding sanity check
if ~ismember(3, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupValidateOrigAuCoding(pathTbl);
    end
end
