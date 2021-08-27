% Prepare the setup for KNN classification - Upper Face

procDataDir_allSubj = '[path_to_MaqFACS_training_data_main_dir]\MaqFACS_training_data_processed';
subjNames = {'L','M','K','Q','R'}; 

allSubjDirName = strjoin(subjNames,'_');   
allSubjMetaDir = fullfile(procDataDir_allSubj, allSubjDirName);

allSubjMetaDir_Exper = '[path_to_MaqFACS_test_data_main_dir]\MaqFACS_test_data_processed\D';
experSubjName = 'D';

%% Params

% Get the images size
[pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{1});
dataFolder = pathTbl.upperFaceDBRDir_DeltaOneFr{1};
imgSizePath = sprintf('%s/imageSize.mat',dataFolder);


%% From here and on:
imgTablesDir_UpperFace = 'AUsImgTables_UpperFace_DeltaOneFr';


%% Tests: 3 AUs, Fascicularis subj. D, [equal classes size]

% Training tables (Rhesus subjects)
framesTblsFileNames    = {'AU_1_2_FramesTbl_fromDBs_allSubj.mat',...
                          'AU_43_FramesTbl_fromDBs_allSubj.mat',...
                          'neutralAbs_FramesTbl_fromDBs_allSubj_med.mat'};

% Test tables (Fascicularis subject)
framesTblsFileNames_Exper = {'AU_1_2_FramesTbl_fromDBs_allSubj.mat',...
                             'AU_43_5_FramesTbl_fromDBs_allSubj.mat',...
                             'neutralAbs_FramesTbl_fromDBs_allSubj.mat'};  
                    