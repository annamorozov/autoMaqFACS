function [pathTbl, wholeSubjPath] = setupInitializePath(rawDataDir, procDataDir, subjName, vidExten, vidPrefix2Del)

%TODO: refactor this code. This got too big and unmaintanable. Change the
%cells to structs.

% Table columns: rawVidDir, shortXlsDir, dataDir, trainingDir, 
% parsedAUsDir, segmentDir, segmentMetaDir, segmentCropDir,
% segmentCropDBDir ... 
% Each row is a movie (the name of the row is pure movie name)

% vidExten, vidPrefix2Del - optional params

wholeSubjPath.AUsAnalysisDir          = fullfile(procDataDir, 'subjAUsAnalysis');
wholeSubjPath.AUsUpperFaceAnalysisDir = fullfile(procDataDir, 'subjUpperAUsAnalysis');
wholeSubjPath.AUsLowerFaceAnalysisDir = fullfile(procDataDir, 'subjLowerAUsAnalysis');
wholeSubjPath.MetaDir                 = fullfile(procDataDir, 'Meta');

rawVidDirVar = fullfile(rawDataDir, 'Videos');
shortXlsDir  = fullfile(rawDataDir, 'Xls', 'Short');
fullXlsDir   = fullfile(rawDataDir, 'Xls', 'Full');

if nargin < 4 || isempty(vidExten)  % vidExten
    vidExten = 'wmv';
end
vidNamePattern = sprintf('*.%s', vidExten);
files = dir(fullfile(rawVidDirVar, vidNamePattern));

nRows = length(files);

names                      = cell(nRows, 1);
dataDir                    = cell(nRows, 1);
trainingDir                = cell(nRows, 1);
parsedAUsDir               = cell(nRows, 1);
AusAnalysisDir             = cell(nRows, 1);

trainAlignMaskingDir            = cell(nRows, 1);
trainAlignMaskingMetaDir        = cell(nRows, 1);
trainAlignMaskingClassifDir     = cell(nRows, 1);
trainAlignMaskingClassifRunDir  = cell(nRows, 1);
trainAlignMaskingDBDir          = cell(nRows, 1);
trainAlignMaskingDBRunDir       = cell(nRows, 1);
trainAlignMaskTrnTblsDir        = cell(nRows, 1);
trainAlignMaskTrnTblsRunDir     = cell(nRows, 1);

trainMaskingDir            = cell(nRows, 1);
trainMaskingMetaDir        = cell(nRows, 1);
trainMaskingClassifDir     = cell(nRows, 1);
trainMaskingClassifRunDir  = cell(nRows, 1);
trainMaskingDBDir          = cell(nRows, 1);
trainMaskingDBRunDir       = cell(nRows, 1);
trainMaskTrnTblsDir        = cell(nRows, 1);
trainMaskTrnTblsRunDir     = cell(nRows, 1);

segmentDir                 = cell(nRows, 1);
segmentMetaDir             = cell(nRows, 1);
segmentDBDir               = cell(nRows, 1);  % Global dir for DBs
segmentTrainTblsDir        = cell(nRows, 1);  % Global dir for training tables
segmentDBRunDir            = cell(nRows, 1);  % Dir for DB of specific run
segmentTrainTblsRunDir     = cell(nRows, 1);  % Dir for training tables of specific run
segmentCropDir             = cell(nRows, 1);
segmentCropDBDir           = cell(nRows, 1);

faceROIsDir                 = cell(nRows, 1);
faceROIsMetaDir             = cell(nRows, 1);
upperFaceDir                = cell(nRows, 1);
lowerFaceDir                = cell(nRows, 1);
leftEarDir                  = cell(nRows, 1);
rightEarDir                 = cell(nRows, 1);

upperFaceDBDir                        = cell(nRows, 1);  % Global dir for DBs
upperFaceTrainTblsDir                 = cell(nRows, 1);  % Global dir for training tables
upperFaceDBRunDir                     = cell(nRows, 1);  % Dir for DB of specific run
upperFaceTrainTblsRunDir              = cell(nRows, 1);  % Dir for training tables of specific run
upperFaceAusAnalysisDir               = cell(nRows, 1);
upperFaceDBRDir_DeltaOneFr            = cell(nRows, 1);  % Dir for DB of specific run - delta vid vs. one neutral frame
upperFaceDBRDir_DeltaOneFr_woEyes     = cell(nRows, 1);  % Dir for DB of specific run - delta vid vs. one neutral frame
upperFaceDBRDir_DeltaOneFr_woEyes_big = cell(nRows, 1);  % Dir for DB of specific run - delta vid vs. one neutral frame
upperFaceTrainTblsDir_DeltaOneFr      = cell(nRows, 1);  % Dir for training tables of specific run - delta vid vs. one neutral frame

lowerFaceDBDir               = cell(nRows, 1);  % Global dir for DBs
lowerFaceTrainTblsDir        = cell(nRows, 1);  % Global dir for training tables
lowerFaceDBRunDir            = cell(nRows, 1);  % Dir for DB of specific run
lowerFaceTrainTblsRunDir     = cell(nRows, 1);  % Dir for training tables of specific run
lowerFaceAusAnalysisDir      = cell(nRows, 1);
lowerFaceDBRDir_DeltaOneFr   = cell(nRows, 1);  % Dir for DB of specific run - delta vid vs. one neutral frame

leftEarDBDir                = cell(nRows, 1);  % Global dir for DBs
leftEarTrainTblsDir         = cell(nRows, 1);  % Global dir for training tables
leftEarDBRunDir             = cell(nRows, 1);  % Dir for DB of specific run
leftEarTrainTblsRunDir      = cell(nRows, 1);  % Dir for training tables of specific run

rightEarDBDir               = cell(nRows, 1);  % Global dir for DBs
rightEarTrainTblsDir        = cell(nRows, 1);  % Global dir for training tables
rightEarDBRunDir            = cell(nRows, 1);  % Dir for DB of specific run
rightEarTrainTblsRunDir     = cell(nRows, 1);  % Dir for training tables of specific run

upperFaceDBRunDirEigfData   = cell(nRows, 1);
lowerFaceDBRunDirEigfData   = cell(nRows, 1);
leftEarDBRunDirEigfData     = cell(nRows, 1);
rightEarDBRunDirEigfData    = cell(nRows, 1);

rawVidFile                   = cell(nRows, 1);
shortXlsFile                 = cell(nRows, 1);
fullXlsFile                  = cell(nRows, 1);
vidMetaDataFile              = cell(nRows, 1);
parsedAUsFile                = cell(nRows, 1);
cleanedAUsTblsFile           = cell(nRows, 1);
AUsFramesTblsFile            = cell(nRows, 1);
trainingVidFile              = cell(nRows, 1);
alignedVidFile               = cell(nRows, 1);
polyMaskedVidFile            = cell(nRows, 1);
alignedPolyMaskedVidFile     = cell(nRows, 1);
alignedMaskedEyesVidFile     = cell(nRows, 1);
alignedMaskedEyesVidFile_big = cell(nRows, 1);
segmentVidFile               = cell(nRows, 1);
segmentDBRunEigfData         = cell(nRows, 1);
segmentCropVidFile           = cell(nRows, 1);
polyMaskedDBRunEigfData      = cell(nRows, 1);
alignPolyMaskedDBRunEigfData = cell(nRows, 1);

upperFaceTrainingVidFile     = cell(nRows, 1);
lowerFaceTrainingVidFile     = cell(nRows, 1);
leftEarTrainingVidFile       = cell(nRows, 1);
rightEarTrainingVidFile      = cell(nRows, 1);

upperFaceTrainingDeltaVidFile     = cell(nRows, 1);
lowerFaceTrainingDeltaVidFile     = cell(nRows, 1);
leftEarTrainingDeltaVidFile       = cell(nRows, 1);
rightEarTrainingDeltaVidFile      = cell(nRows, 1);

upperFaceTrainingDeltaOneFrVidFile     = cell(nRows, 1);
lowerFaceTrainingDeltaOneFrVidFile     = cell(nRows, 1);
leftEarTrainingDeltaOneFrVidFile       = cell(nRows, 1);
rightEarTrainingDeltaOneFrVidFile      = cell(nRows, 1);

upperFaceTrainingVidFile_woEyes                 = cell(nRows, 1);
upperFaceTrainingDeltaOneFrVidFile_woEyes       = cell(nRows, 1);
upperFaceTrainingVidFile_woEyes_big             = cell(nRows, 1);
upperFaceTrainingDeltaOneFrVidFile_woEyes_big   = cell(nRows, 1);

upperFaceDBRunEigfData     = cell(nRows, 1);
lowerFaceDBRunEigfData     = cell(nRows, 1);
leftEarDBRunEigfData       = cell(nRows, 1);
rightEarDBRunEigfData      = cell(nRows, 1);

upperFaceAUsFramesTblsFile = cell(nRows, 1);
lowerFaceAUsFramesTblsFile = cell(nRows, 1);

rawVidDir   = repmat({rawVidDirVar}, nRows, 1);
shortXlsDir = repmat({shortXlsDir}, nRows, 1);
fullXlsDir  = repmat({fullXlsDir}, nRows, 1);

for i = 1:length(files)
    [~,name,~] = fileparts(files(i).name);
    if nargin > 4   % vidPrefix2Del
        name = erase(name, vidPrefix2Del);
    end
    names{i} = name;
    
    dataDir{i}                 = fullfile(procDataDir,name);
    trainingDir{i}             = fullfile(dataDir{i},        'Training');
    parsedAUsDir{i}            = fullfile(trainingDir{i},    'ParsedAUs');
    AusAnalysisDir{i}          = fullfile(trainingDir{i},    'AUsAnalysis');
    
    trainAlignMaskingDir{i}         = fullfile(trainingDir{i},            'AlignedMasking');
    trainAlignMaskingMetaDir{i}     = fullfile(trainAlignMaskingDir{i},   'Meta');
    trainAlignMaskingDBDir{i}       = fullfile(trainAlignMaskingDir{i},   'DB');
    trainAlignMaskingClassifDir{i}  = fullfile(trainAlignMaskingDir{i},   'Classifiers');
    trainAlignMaskTrnTblsDir{i}     = fullfile(trainAlignMaskingDir{i},   'TrainTbls');
    
    trainMaskingDir{i}         = fullfile(trainingDir{i},     'Masking');
    trainMaskingMetaDir{i}     = fullfile(trainMaskingDir{i}, 'Meta');
    trainMaskingDBDir{i}       = fullfile(trainMaskingDir{i}, 'DB');
    trainMaskingClassifDir{i}  = fullfile(trainMaskingDir{i}, 'Classifiers');
    trainMaskTrnTblsDir{i}     = fullfile(trainMaskingDir{i}, 'TrainTbls');
    
    segmentDir{i}              = fullfile(trainingDir{i},    'Segmentation');
    segmentMetaDir{i}          = fullfile(segmentDir{i},     'Meta');
    segmentDBDir{i}            = fullfile(segmentDir{i},     'DB');
    segmentTrainTblsDir{i}     = fullfile(segmentDir{i},     'TrainTbls');
    segmentCropDir{i}          = fullfile(segmentDir{i},     'Cropped');
    segmentCropDBDir{i}        = fullfile(segmentCropDir{i}, 'DB');
    
    %TODO: generate names for specific runs
    segmentDBRunDir{i}         = fullfile(segmentDBDir{i},          sprintf('DB_%s',name));
    segmentTrainTblsRunDir{i}  = fullfile(segmentTrainTblsDir{i},   sprintf('TrTbl_%s',name));
    
    trainAlignMaskingDBRunDir{i}      = fullfile(trainAlignMaskingDBDir{i},         sprintf('DB_%s',name));
    trainAlignMaskingClassifRunDir{i} = fullfile(trainAlignMaskingClassifDir{i},    sprintf('Classif_%s',name));
    trainAlignMaskTrnTblsRunDir{i}    = fullfile(trainAlignMaskTrnTblsDir{i},       sprintf('TrTbl_%s',name));
    
    trainMaskingDBRunDir{i}      = fullfile(trainMaskingDBDir{i},         sprintf('DB_%s',name));
    trainMaskingClassifRunDir{i} = fullfile(trainMaskingClassifDir{i},    sprintf('Classif_%s',name));
    trainMaskTrnTblsRunDir{i}    = fullfile(trainMaskTrnTblsDir{i},       sprintf('TrTbl_%s',name));
    
    faceROIsDir{i}                 = fullfile(trainingDir{i},     'FaceROIs');
    faceROIsMetaDir{i}             = fullfile(faceROIsDir{i},     'Meta');
    upperFaceDir{i}                = fullfile(faceROIsDir{i},     'UpperFace');
    lowerFaceDir{i}                = fullfile(faceROIsDir{i},     'LowerFace');
    leftEarDir{i}                  = fullfile(faceROIsDir{i},     'LeftEar');
    rightEarDir{i}                 = fullfile(faceROIsDir{i},     'RightEar');
    
    upperFaceDBDir{i}                        = fullfile(upperFaceDir{i},     'DB');  % Global dir for DBs
    upperFaceTrainTblsDir{i}                 = fullfile(upperFaceDir{i},     'TrainTbls');  % Global dir for training tables
    upperFaceDBRunDir{i}                     = fullfile(upperFaceDir{i},     sprintf('DB_%s',name));  % Dir for DB of specific run
    upperFaceTrainTblsRunDir{i}              = fullfile(upperFaceDir{i},     sprintf('TrTbl_%s',name));  % Dir for training tables of specific run
    upperFaceAusAnalysisDir{i}               = fullfile(upperFaceDir{i},     'AUsAnalysis');
    upperFaceDBRDir_DeltaOneFr{i}            = fullfile(upperFaceDir{i},     sprintf('DB_%s_delta_1_neutr_fr',name));  % Dir for DB of specific run - delta vid vs. one neutral frame
    upperFaceDBRDir_DeltaOneFr_woEyes{i}     = fullfile(upperFaceDir{i},     sprintf('DB_%s_delta_1_neutr_fr_woEyes',name));  % Dir for DB of specific run - delta vid vs. one neutral frame
    upperFaceDBRDir_DeltaOneFr_woEyes_big{i} = fullfile(upperFaceDir{i},     sprintf('DB_%s_delta_1_neutr_fr_woEyes_big',name));  % Dir for DB of specific run - delta vid vs. one neutral frame
    upperFaceTrainTblsDir_DeltaOneFr{i}      = fullfile(upperFaceDir{i},     sprintf('TrTbl_%s_delta_1_neutr_fr',name));  % Dir for training tables of specific run - delta vid vs. one neutral frame
    

    lowerFaceDBDir{i}               = fullfile(lowerFaceDir{i},     'DB');  % Global dir for DBs
    lowerFaceTrainTblsDir{i}        = fullfile(lowerFaceDir{i},     'TrainTbls');  % Global dir for training tables
    lowerFaceDBRunDir{i}            = fullfile(lowerFaceDir{i},     sprintf('DB_%s',name));  % Dir for DB of specific run
    lowerFaceTrainTblsRunDir{i}     = fullfile(lowerFaceDir{i},     sprintf('TrTbl_%s',name));  % Dir for training tables of specific run
    lowerFaceAusAnalysisDir{i}      = fullfile(lowerFaceDir{i},     'AUsAnalysis');
    lowerFaceDBRDir_DeltaOneFr{i}   = fullfile(lowerFaceDir{i},     sprintf('DB_%s_delta_1_neutr_fr',name));  % Dir for DB of specific run - delta vid vs. one neutral frame

    leftEarDBDir{i}                = fullfile(leftEarDir{i},        'DB');  % Global dir for DBs
    leftEarTrainTblsDir{i}         = fullfile(leftEarDir{i},        'TrainTbls');  % Global dir for training tables
    leftEarDBRunDir{i}             = fullfile(leftEarDir{i},        sprintf('DB_%s',name));  % Dir for DB of specific run
    leftEarTrainTblsRunDir{i}      = fullfile(leftEarDir{i},        sprintf('TrTbl_%s',name));  % Dir for training tables of specific run

    rightEarDBDir{i}               = fullfile(rightEarDir{i},       'DB');  % Global dir for DBs
    rightEarTrainTblsDir{i}        = fullfile(rightEarDir{i},       'TrainTbls');  % Global dir for training tables
    rightEarDBRunDir{i}            = fullfile(rightEarDir{i},       sprintf('DB_%s',name));  % Dir for DB of specific run
    rightEarTrainTblsRunDir{i}     = fullfile(rightEarDir{i},       sprintf('TrTbl_%s',name));  % Dir for training tables of specific run

    
    rawVidFile{i}               = fullfile(files(i).folder,     files(i).name);
    shortXlsFile{i}             = fullfile(shortXlsDir{i},      sprintf('%s.xlsx',name));
    fullXlsFile{i}              = fullfile(fullXlsDir{i},       sprintf('Monkey %s - %s - Event Logs.xlsx',subjName, name));
    vidMetaDataFile{i}          = fullfile(dataDir{i},          'VidMetaData.mat');
    parsedAUsFile{i}            = fullfile(parsedAUsDir{i},     'ParsedAUs.mat');
    cleanedAUsTblsFile{i}       = fullfile(parsedAUsDir{i},     'CleanedTbls.mat');
    AUsFramesTblsFile{i}        = fullfile(trainingDir{i},      'AUsAndFramesTbls.mat');
    trainingVidFile{i}          = fullfile(trainingDir{i},      sprintf('%s_training.mj2',name));
    
    upperFaceTrainingVidFile{i}     = fullfile(upperFaceDir{i},      sprintf('%s_trainingUpperFace.mj2',name));
    lowerFaceTrainingVidFile{i}     = fullfile(lowerFaceDir{i},      sprintf('%s_trainingLowerFace.mj2',name));
    leftEarTrainingVidFile{i}       = fullfile(leftEarDir{i},        sprintf('%s_trainingLeftEar.mj2'  ,name));
    rightEarTrainingVidFile{i}      = fullfile(rightEarDir{i},       sprintf('%s_trainingRightEar.mj2' ,name));
    
    upperFaceTrainingDeltaVidFile{i}     = fullfile(upperFaceDir{i},      sprintf('%s_trainingUpperFace_delta.mj2',name));
    lowerFaceTrainingDeltaVidFile{i}     = fullfile(lowerFaceDir{i},      sprintf('%s_trainingLowerFace_delta.mj2',name));
    leftEarTrainingDeltaVidFile{i}       = fullfile(leftEarDir{i},        sprintf('%s_trainingLeftEar_delta.mj2'  ,name));
    rightEarTrainingDeltaVidFile{i}      = fullfile(rightEarDir{i},       sprintf('%s_trainingRightEar_delta.mj2' ,name));
    
    upperFaceTrainingDeltaOneFrVidFile{i}     = fullfile(upperFaceDir{i},      sprintf('%s_trainingUpperFace_delta_1_neutr_fr.mj2',name));
    lowerFaceTrainingDeltaOneFrVidFile{i}     = fullfile(lowerFaceDir{i},      sprintf('%s_trainingLowerFace_delta_1_neutr_fr.mj2',name));
    leftEarTrainingDeltaOneFrVidFile{i}       = fullfile(leftEarDir{i},        sprintf('%s_trainingLeftEar_delta_1_neutr_fr.mj2'  ,name));
    rightEarTrainingDeltaOneFrVidFile{i}      = fullfile(rightEarDir{i},       sprintf('%s_trainingRightEar_delta_1_neutr_fr.mj2' ,name));
    
    upperFaceTrainingVidFile_woEyes{i}               = fullfile(upperFaceDir{i},   sprintf('%s_trainingUpperFace_woEyes.mj2',name));
    upperFaceTrainingDeltaOneFrVidFile_woEyes{i}     = fullfile(upperFaceDir{i},   sprintf('%s_trainingUpperFace_delta_1_neutr_fr_woEyes.mj2',name));
    upperFaceTrainingVidFile_woEyes_big{i}           = fullfile(upperFaceDir{i},   sprintf('%s_trainingUpperFace_woEyes_big.mj2',name));
    upperFaceTrainingDeltaOneFrVidFile_woEyes_big{i} = fullfile(upperFaceDir{i},   sprintf('%s_trainingUpperFace_delta_1_neutr_fr_woEyes_big.mj2',name));
    
    upperFaceDBRunEigfData{i}         = fullfile(upperFaceDBRunDir{i},           'eigfacesData.mat');
    lowerFaceDBRunEigfData{i}         = fullfile(lowerFaceDBRunDir{i},           'eigfacesData.mat');
    leftEarDBRunEigfData{i}           = fullfile(leftEarDBRunDir{i},             'eigfacesData.mat');
    rightEarDBRunEigfData{i}          = fullfile(rightEarDBRunDir{i},            'eigfacesData.mat');
    
    upperFaceAUsFramesTblsFile{i}        = fullfile(upperFaceDir{i},      'AUsAndFramesTbls.mat');
    lowerFaceAUsFramesTblsFile{i}        = fullfile(lowerFaceDir{i},      'AUsAndFramesTbls.mat');
     
    alignedVidFile{i}               = fullfile(trainingDir{i},          sprintf('%s_aligned2PredefLoc.mj2',name));
    alignedPolyMaskedVidFile{i}     = fullfile(trainAlignMaskingDir{i}, sprintf('%s_training_align_poly_mask.mj2',name));
    alignedMaskedEyesVidFile{i}     = fullfile(trainingDir{i},          sprintf('%s_maskedEyes.mj2',name));
    alignedMaskedEyesVidFile_big{i} = fullfile(trainingDir{i},          sprintf('%s_maskedEyes_big.mj2',name));


    polyMaskedVidFile{i}            = fullfile(trainMaskingDir{i},           sprintf('%s_training_poly_mask.mj2',name));
    segmentVidFile{i}               = fullfile(segmentDir{i},                sprintf('%s_training_seg.mj2',name));
    segmentDBRunEigfData{i}         = fullfile(segmentDBRunDir{i},           'eigfacesData.mat');
    polyMaskedDBRunEigfData{i}      = fullfile(trainMaskingDBRunDir{i},      'eigfacesData.mat');
    alignPolyMaskedDBRunEigfData{i} = fullfile(trainAlignMaskingDBRunDir{i}, 'eigfacesData.mat');
    segmentCropVidFile{i}           = fullfile(segmentCropDir{i},            sprintf('%s_training_seg_crop.mj2',name));
end

pathTbl = table(rawVidDir, shortXlsDir, fullXlsDir, dataDir, trainingDir, parsedAUsDir, AusAnalysisDir,...
    trainMaskingDir, trainMaskingMetaDir, polyMaskedVidFile,...
    trainMaskingDBDir, trainMaskTrnTblsDir, trainMaskingDBRunDir, trainMaskTrnTblsRunDir,...
    trainMaskingClassifDir, trainMaskingClassifRunDir,...
    trainAlignMaskingDir, trainAlignMaskingMetaDir, trainAlignMaskingDBDir,... 
    trainAlignMaskingClassifDir, trainAlignMaskTrnTblsDir, alignedPolyMaskedVidFile, alignedMaskedEyesVidFile,...
    trainAlignMaskingDBRunDir, trainAlignMaskingClassifRunDir, trainAlignMaskTrnTblsRunDir,...
    segmentDir, segmentMetaDir, segmentDBDir, segmentTrainTblsDir, segmentDBRunDir,...
    segmentTrainTblsRunDir, segmentCropDir, segmentCropDBDir, rawVidFile,...
    shortXlsFile, fullXlsFile, vidMetaDataFile, parsedAUsFile, cleanedAUsTblsFile,...
    AUsFramesTblsFile, trainingVidFile, alignedVidFile, segmentVidFile, segmentDBRunEigfData,... 
    segmentCropVidFile, polyMaskedDBRunEigfData, alignPolyMaskedDBRunEigfData,...
    faceROIsDir, faceROIsMetaDir, upperFaceDir, lowerFaceDir, leftEarDir, rightEarDir,...     
    upperFaceAUsFramesTblsFile, lowerFaceAUsFramesTblsFile,...
    upperFaceDBDir, upperFaceTrainTblsDir, upperFaceDBRunDir, upperFaceTrainTblsRunDir, upperFaceAusAnalysisDir,...
    lowerFaceDBDir, lowerFaceTrainTblsDir, lowerFaceDBRunDir, lowerFaceTrainTblsRunDir, lowerFaceAusAnalysisDir, lowerFaceDBRDir_DeltaOneFr,... 
    leftEarDBDir, leftEarTrainTblsDir, leftEarDBRunDir, leftEarTrainTblsRunDir,... 
    rightEarDBDir, rightEarTrainTblsDir, rightEarDBRunDir, rightEarTrainTblsRunDir,...
    upperFaceTrainingVidFile, lowerFaceTrainingVidFile, leftEarTrainingVidFile, rightEarTrainingVidFile,... 
    upperFaceTrainingDeltaVidFile, lowerFaceTrainingDeltaVidFile, leftEarTrainingDeltaVidFile, rightEarTrainingDeltaVidFile,...
    upperFaceDBRDir_DeltaOneFr, upperFaceDBRDir_DeltaOneFr_woEyes, upperFaceTrainTblsDir_DeltaOneFr,...
    upperFaceTrainingDeltaOneFrVidFile, lowerFaceTrainingDeltaOneFrVidFile, leftEarTrainingDeltaOneFrVidFile, rightEarTrainingDeltaOneFrVidFile,...
    upperFaceTrainingVidFile_woEyes, upperFaceTrainingDeltaOneFrVidFile_woEyes,...
    upperFaceDBRunEigfData, lowerFaceDBRunEigfData, leftEarDBRunEigfData, rightEarDBRunEigfData,...
    upperFaceDBRDir_DeltaOneFr_woEyes_big, alignedMaskedEyesVidFile_big, upperFaceTrainingVidFile_woEyes_big, upperFaceTrainingDeltaOneFrVidFile_woEyes_big);

% This needs to be here in order to be executed (after the table has been initialized)
pathTbl.Properties.RowNames = names;
