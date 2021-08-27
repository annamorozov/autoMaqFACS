function fullSetupAllSubj_BuildTrain_Increment(procDataDir_allSubj, subjNames, sectionsToSkip)

% sectionsToSkip - optional param: may be specified to skip running of
%                  code sections.

if nargin < 3   % sectionsToSkip
    sectionsToSkip = [];
end

%% Section 1: Building training videos
if ~ismember(1, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        % Prepare training vid
        % This is a long run
        isSavePreviewVid = true;
        setupPrepareTrainingVideos(pathTbl, isSavePreviewVid);
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