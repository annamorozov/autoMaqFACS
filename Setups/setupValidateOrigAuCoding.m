function setupValidateOrigAuCoding(pathTbl, sectionsToSkip)
% Create videos of easy recognizable AUs for coding sanity check

if nargin < 2   % sectionsToSkip
    sectionsToSkip = [];
end

for i = 1:height(pathTbl)
    trainingVid = pathTbl.trainingVidFile{i};
    [trainDir, trainName, ~] = fileparts(trainingVid);
    
    load(pathTbl.AUsFramesTblsFile{i}, 'AUs_summary_tbl', 'training_matchedTimes_tbl');
    
    validDir = fullfile(trainDir, 'ValidationVideos');
    if ~exist(validDir, 'dir')
        mkdir(validDir);
    end
    
    %% Extract only AU_43 frames form training vid
    if ~ismember(1, sectionsToSkip)
        if any(strcmp(AUs_summary_tbl.Properties.VariableNames,'AU_43'))
            AU43_Vid = fullfile(validDir, sprintf('%s_AU43.avi', trainName));

            AU43_GlobalIndx = AUs_summary_tbl.AU_43{3,1};  
            AU43_TrainingVidIndx = AU43_GlobalIndx - training_matchedTimes_tbl.Frame_n(1) + 1;

            extractSpecificFramesFromVid(trainingVid, AU43_Vid, 'framesIndVec', ...
                AU43_TrainingVidIndx);
        end
    end
    
    %% Extract only AU_45 frames form training vid
    if ~ismember(2, sectionsToSkip)
        if any(strcmp(AUs_summary_tbl.Properties.VariableNames,'AU_45'))
            AU45_Vid = fullfile(validDir, sprintf('%s_AU45.avi', trainName));

            AU45_GlobalIndx = AUs_summary_tbl.AU_45{3,1};  
            AU45_TrainingVidIndx = AU45_GlobalIndx - training_matchedTimes_tbl.Frame_n(1) + 1;

            extractSpecificFramesFromVid(trainingVid, AU45_Vid, 'framesIndVec', ...
                AU45_TrainingVidIndx);
        end
    end

    %% Extract only AU_18i frames from training vid
    if ~ismember(3, sectionsToSkip)
        if any(strcmp(AUs_summary_tbl.Properties.VariableNames,'AU_18i'))
            AU18i_Vid = fullfile(validDir, sprintf('%s_AU18i.avi', trainName));

            AU18i_GlobalIndx = AUs_summary_tbl.AU_18i{3,1};  
            AU18i_TrainingVidIndx = AU18i_GlobalIndx - training_matchedTimes_tbl.Frame_n(1) + 1;

            extractSpecificFramesFromVid(trainingVid, AU18i_Vid, 'framesIndVec', ...
                AU18i_TrainingVidIndx);
        end
    end
    
    %% Extract only AU_18ii frames form training vid
    if ~ismember(4, sectionsToSkip)
        if any(strcmp(AUs_summary_tbl.Properties.VariableNames,'AU_18ii'))
            AU18ii_Vid = fullfile(validDir, sprintf('%s_AU18ii.avi', trainName));

            AU18ii_GlobalIndx = AUs_summary_tbl.AU_18ii{3,1};  
            AU18ii_TrainingVidIndx = AU18ii_GlobalIndx - training_matchedTimes_tbl.Frame_n(1) + 1;

            extractSpecificFramesFromVid(trainingVid, AU18ii_Vid, 'framesIndVec', ...
                AU18ii_TrainingVidIndx);
        end
    end
    
    %% Extract only AU_1_2 frames form training vid
    if ~ismember(5, sectionsToSkip)
        if any(strcmp(AUs_summary_tbl.Properties.VariableNames,'AU_1_2'))
            AU1_2_Vid = fullfile(validDir, sprintf('%s_AU1_2.avi', trainName));

            AU1_2_GlobalIndx = AUs_summary_tbl.AU_1_2{3,1};  
            AU1_2_TrainingVidIndx = AU1_2_GlobalIndx - training_matchedTimes_tbl.Frame_n(1) + 1;

            extractSpecificFramesFromVid(trainingVid, AU1_2_Vid, 'framesIndVec', ...
                AU1_2_TrainingVidIndx);
        end
    end
    
    %% Extract only AU_19 frames form training vid
    if ~ismember(6, sectionsToSkip)
        if any(strcmp(AUs_summary_tbl.Properties.VariableNames,'AU_19'))
            AU19_Vid = fullfile(validDir, sprintf('%s_AU19.avi', trainName));

            AU19_GlobalIndx = AUs_summary_tbl.AU_19{3,1};  
            AU19_TrainingVidIndx = AU19_GlobalIndx - training_matchedTimes_tbl.Frame_n(1) + 1;

            extractSpecificFramesFromVid(trainingVid, AU19_Vid, 'framesIndVec', ...
                AU19_TrainingVidIndx);
        end
    end
end