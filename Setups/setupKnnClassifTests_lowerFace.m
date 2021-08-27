% Prepare the setup for KNN classification - Lower Face

procDataDir_allSubj = '[path_to_MaqFACS_training_data_main_dir]\MaqFACS_training_data_processed';
subjNames = {'L','M','K','Q','R'}; 

allSubjDirName = strjoin(subjNames,'_');   
allSubjMetaDir = fullfile(procDataDir_allSubj, allSubjDirName);

allSubjMetaDir_Exper = '[path_to_MaqFACS_test_data_main_dir]\MaqFACS_test_data_processed\D';
experSubjName = 'D';

%% Params

% Get the images size
[pathTbl, wholeSubjPath] = loadPathTbls(procDataDir_allSubj, subjNames{1});
dataFolder = pathTbl.lowerFaceDBRDir_DeltaOneFr{1};
imgSizePath = sprintf('%s/imageSize.mat',dataFolder);


%% From here and on:
imgTablesDir_LowerFace = 'AUsImgTables_LowerFace_DeltaOneFr';

tblInnerName = 'AUs_FramesTbl_fromDBs_allSubj';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Tests with AUs 18i and 16 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tests: 3 AUs, Fascicularis subj. D, [equal classes size]

% Training tables (Rhesus subjects)
framesTblsFileNames    = {'AU_25_AU_26_FramesTbl_fromDBs_allSubj.mat',...
                          'AU_25_AU_26_AU_16_FramesTbl_fromDBs_allSubj.mat',...
                          'AU_25_AU_26_AU_18i_FramesTbl_fromDBs_allSubj.mat'};

% Test tables (Fascicularis subject)                     
framesTblsFileNames_Exper = {'AU_25_AU_26_FramesTbl_fromDBs_allSubj.mat',...
                             'AU_25_AU_26_AU_16_FramesTbl_fromDBs_allSubj.mat',...
                             'AU_25_AU_26_AU_18i_FramesTbl_fromDBs_allSubj.mat'};
