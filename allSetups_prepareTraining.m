%% Prepare the training data (Rhesus)

%% Params
procDataDir_allSubj = '[path_to_MaqFACS_training_data_main_dir]\MaqFACS_training_data_processed';
rawDataMainDir = '[path_to_MaqFACS_training_data_main_dir]\RawData\MaqFACS';

subjNames = {'L','M','K','Q','R'};  % % for example: Rhesus monkeys  

%%%%%%%%%%%%%%%%%%%%%%%% Setups %%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize the path for processing and analysis
vidExten = 'wmv';
fullSetupAllSubjInitializePath(rawDataMainDir, procDataDir_allSubj, subjNames, vidExten);

%% Parse AUs from labeled data and sync with the labeled videos
fullSetupAllSubjParseSyncAUsIncrement(procDataDir_allSubj, subjNames);

%% Build the relevant videos for training
% Building training video and sanity checks (specific AUs videos)
fullSetupAllSubj_BuildTrain_Increment(procDataDir_allSubj, subjNames);

%% Analyse the AUs (in labeled videos) - frequencies, correlations etc...
fullSetupAllSubj_AUsProc_Increment(procDataDir_allSubj, subjNames);

%% Align the training videos
fullSetupAllSubjAlignIncrement(procDataDir_allSubj, subjNames, 0);

%% Devide the data and videos to ROIs (upper and lower face, ears)

fullSetupAllSubjFaceROIsIncrement(procDataDir_allSubj, subjNames);

%% Create the "delta" images and save all the training images to DBs
fullSetupPrepareTrainingDBs_UpperFace(procDataDir_allSubj, subjNames);

sectionsToSkip = 1; % skip choosing the best neutral frames
fullSetupPrepareTrainingDBs_LowerFace(procDataDir_allSubj, subjNames, sectionsToSkip);

%% Prepare the actual tables for classifiers training
fullSetupPrepareTrainingData_UpperFace(procDataDir_allSubj, subjNames)

fullSetupPrepareTrainingData_LowerFace(procDataDir_allSubj, subjNames);
