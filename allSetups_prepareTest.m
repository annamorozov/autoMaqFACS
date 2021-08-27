%% Prepare the test data (new species - Fascicularis)

%% Params
procDataDir_allSubj = '[path_to_MaqFACS_test_data_main_dir]\MaqFACS_test_data_processed';
rawDataMainDir = '[path_to_MaqFACS_test_data_main_dir]\RawData';

subjNames = {'D'};  % for example: Fascicularis monkey D

%%%%%%%%%%%%%%%%%%%%%%%% Setups %%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize the path for processing and analysis
vidExten = 'mj2';
fullSetupAllSubjInitializePath(rawDataMainDir, procDataDir_allSubj, subjNames, vidExten);

%% Parse AUs from labeled data and sync with the labeled videos
fullSetupAllSubjParseSyncAUsIncrement(procDataDir_allSubj, subjNames);

%% Analyse the AUs (in labeled videos) - frequencies, correlations etc...
%sectionsToSkip = [...];    Optionally skip the parts of analysis of
%           `               multiple subjects, if you have only one subject for testing
fullSetupAllSubj_AUsProc_Increment(procDataDir_allSubj, subjNames);

%% Build the relevant videos for (validation and) testing
% Building training video and sanity checks (specific AUs videos)

% Path to the Meta dir of one of the subject in the training sets (the globalAlignParamsDir)
globalAlignParamsDir = '[path_to_MaqFACS_training_data_main_dir]\MaqFACS_training_data_processed\[trainSubj1]\Meta';

exper_fullSetupAllSubj_BuildTest_Increment(procDataDir_allSubj, subjNames,...
    globalAlignParamsDir);

%% Align the (validation and) test videos
fullSetupAllSubjAlignIncrement(procDataDir_allSubj, subjNames, 0);

%% Devide the data and videos to ROIs (upper and lower face, ears)

% The parameters for crop already computed for the training dataset
cropROIsParamsDir = '[path_to_MaqFACS_training_data_main_dir]\MaqFACS_training_data_processed\AllSubj';

exper_fullSetupAllSubjFaceROIsIncrement(procDataDir_allSubj, subjNames, cropROIsParamsDir);

%% Create the "delta" images and save all the (validation and) test images to DBs
% Create delta videos and save them as DB
fullSetupPrepareTrainingDBs_UpperFace(procDataDir_allSubj, subjNames);

sectionsToSkip = 1; % skip choosing the best neutral frames (already done for upper face)
fullSetupPrepareTrainingDBs_LowerFace(procDataDir_allSubj, subjNames, sectionsToSkip);

%% Prepare the actual tables for classifiers (validation and) testing 
% Prepare frames tables for (validation and) testing 

exper_fullSetupPrepareTestData_UpperFace(procDataDir_allSubj, subjNames)

% Can use the same function for creation the training sets but with test
% sets data
fullSetupPrepareTrainingData_LowerFace(procDataDir_allSubj, subjNames);
