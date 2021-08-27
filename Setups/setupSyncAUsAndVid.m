function setupSyncAUsAndVid(pathTbl, lastFrForNeutralFr)
% sync AUs with frame times of the videos
% lastFrForNeutralFr - optional param

isAddTrainFrames = false;

for i = 1 : height(pathTbl)
    load(pathTbl.vidMetaDataFile{i}, 'timesVec');
    if isempty(timesVec)
        error('Failed to load timesVec from %s!\n', pathTbl.vidMetaDataFile{i});
        break;
    end
    
    load(pathTbl.parsedAUsFile{i}, 'AUs_freq_tbl');
    if isempty(AUs_freq_tbl)
        error('Failed to load AUs_freq_tbl from %s!\n', pathTbl.parsedAUsFile{i});
        break;
    end
    
    load(pathTbl.parsedAUsFile{i}, 'AUs_parsed_full_list');
    if isempty(AUs_parsed_full_list)
        error('Failed to load AUs_parsed_full_list from %s!\n', pathTbl.parsedAUsFile{i});
        break;  
    end
    
    load(pathTbl.cleanedAUsTblsFile{i}, 'cleanXlsTbl');
    if isempty(cleanXlsTbl)
        error('Failed to load cleanXlsTbl from %s!\n', pathTbl.cleanedAUsTblsFile{i});
        break;  
    end
    
    try
        [AUs_summary_tbl, AUs_all_tables, formatted_xls_data] = getAUsTables(cleanXlsTbl, AUs_freq_tbl, AUs_parsed_full_list, timesVec);
        training_matchedTimes_tbl = getClosestTimes([formatted_xls_data.Time_Relative_sf(1), formatted_xls_data.Time_Relative_sf(end)],...
            timesVec, isAddTrainFrames);
        
        if nargin > 1  % lastFrForNeutralFr
            training_matchedTimes_tbl.lastFrForNeutralFr(1) = lastFrForNeutralFr;
        end
        
    catch ME
        warning('setupSyncAUsAndVid: failure while processing %s folder!\n', pathTbl.dataDir{i});
        rethrow(ME);
    end 
        
    save(pathTbl.AUsFramesTblsFile{i}, 'AUs_summary_tbl', 'AUs_all_tables', 'formatted_xls_data', 'training_matchedTimes_tbl');
    fprintf('setupSyncAUsAndVid: AUs sync with frames in %s completed successfully.\n', pathTbl.dataDir{i});
end



