function fullSetupAllSubjAlignIncrement(procDataDir_allSubj, subjNames, nFrames2Truncate, copySourceProcDataDir_allSubj, sectionsToSkip)

% nFrames2Truncate - optional param, to truncate frames from neutral frames
%                    sequences

% copySourceProcDataDir_allSubj - optional param, to copy alignment
%                                 parameters from another procDataDir 
%                                 (and not calculating them in this run).

% sectionsToSkip - optional param: may be specified to skip running of
%                  code sections.


isOverrideExisting = true;

if nargin < 4   % copySourceProcDataDir_allSubj
    copySourceProcDataDir_allSubj = '';
end


if nargin < 5   % sectionsToSkip
    sectionsToSkip = [];
end

%% Section 1: Extract neutral frames
if ~ismember(1, sectionsToSkip)
    
    % Extract neutral frames (truncated version)
    if nargin > 2 && nFrames2Truncate ~= 0   % nFrames2Truncate
        for i = 1:length(subjNames)
            [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

            setupGetNeutralFramesInd(pathTbl.trainingDir, pathTbl.AUsFramesTblsFile, nFrames2Truncate);
        end
    end

    % Extract neutral frames (absolute version)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupGetNeutralFramesInd(pathTbl.trainingDir, pathTbl.AUsFramesTblsFile);
    end
end

%% Alignment to predefined locations (landmarks)

% Section 2: Avg neutral img
if ~ismember(2, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        if nargin > 2 && nFrames2Truncate ~= 0  % nFrames2Truncate
            setupGetVidNeutralAvgImg(pathTbl.trainingDir, pathTbl.AUsFramesTblsFile, pathTbl.trainingVidFile,...
                isOverrideExisting, nFrames2Truncate);
        else
            setupGetVidNeutralAvgImg(pathTbl.trainingDir, pathTbl.AUsFramesTblsFile, pathTbl.trainingVidFile,...
                isOverrideExisting);
        end
    end
end

% Section 3: Define the face landmarks
if ~ismember(3, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupMarkFaceLandmarks(pathTbl.trainingDir, pathTbl.trainingVidFile);
    end
end

%%%%%%%%%%%%%%%%%%

%% Section 4: Define global predefined coordinates, towards which the facial landmarks
%% will be transformed
if ~ismember(4, sectionsToSkip) && isempty(copySourceProcDataDir_allSubj)
    iRefVid = 1;
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        setupDefineGlobalAlignCoords(pathTbl.trainingDir{iRefVid}, wholeSubjPath.MetaDir);
        load(fullfile(wholeSubjPath.MetaDir, 'globalAlignParams.mat'),...
            'predefLandmarks', 'outputView');

        setupGetAlignVidTform(pathTbl.trainingDir, pathTbl.trainingVidFile,...
            predefLandmarks, outputView);
        
        close all;
    end
end

%% Section 5: Copy already existing alignment params 
if ~ismember(5, sectionsToSkip) && ~isempty(copySourceProcDataDir_allSubj)
    for i = 1:length(subjNames)
        [srcPathTbl, srcWholeSubjPath] = loadPathTbls(copySourceProcDataDir_allSubj, subjNames{i});
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});
        
        % In case there are already existing alignment parameters we want
        % to use
        setupCopyGlobalAlignCoords(srcWholeSubjPath.MetaDir, wholeSubjPath.MetaDir);
        setupCopyVidAlignParams(srcPathTbl.trainingDir, pathTbl.trainingDir);
    end
end

%% Section 6: Transform the videos
if ~ismember(6, sectionsToSkip)
    for i = 1:length(subjNames)
        [pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{i});

        isSavePreviewVid = false;
        load(fullfile(wholeSubjPath.MetaDir, 'globalAlignParams.mat'), 'outputView');
        setupAlignVid2Ref(pathTbl.trainingDir, pathTbl.trainingVidFile, pathTbl.alignedVidFile, outputView, isSavePreviewVid);
    end
end

