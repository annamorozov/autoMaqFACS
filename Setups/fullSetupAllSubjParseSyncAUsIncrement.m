function fullSetupAllSubjParseSyncAUsIncrement(procDataDir_allSubj, subjNames, sectionsToSkip)
% Parse AUs from labeled data and sync with the (time of) labeled videos
% sectionsToSkip - optional param: may be specified to skip running of
%                  code sections.

if nargin < 3   % sectionsToSkip
    sectionsToSkip = [];
end

% Parse the video data
if ~ismember(1, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupParseVidMeta(pathTbl);
    end
end

% Parse the AU labels data
if ~ismember(2, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupParseAUsData(pathTbl, 1);
    end
end

% Sync AU labels data with video data
if ~ismember(3, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupSyncAUsAndVid(pathTbl);
    end
end

% In case we want to also get the intensities of the AUs
if ~ismember(4, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        setupSyncAUsIntensitiesAndVid(pathTbl);
    end
end