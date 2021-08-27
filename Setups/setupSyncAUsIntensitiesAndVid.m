function setupSyncAUsIntensitiesAndVid(pathTbl)
% Get the intensities of the AUs (e.g. A,B,C...)

for i = 1 : height(pathTbl)
    load(pathTbl.AUsFramesTblsFile{i}, 'AUs_summary_tbl', 'AUs_all_tables');
   
    if isempty(AUs_summary_tbl)
        error('Failed to load AUs_summary_tbl from %s!\n', pathTbl.AUsFramesTblsFile{i});
        break;
    end
    
    if isempty(AUs_all_tables)
        error('Failed to load AUs_all_tables from %s!\n', pathTbl.AUsFramesTblsFile{i});
        break;
    end
    
    load(pathTbl.parsedAUsFile{i}, 'AUs_parsed_full_list');
    if isempty(AUs_parsed_full_list)
        error('Failed to load AUs_parsed_full_list from %s!\n', pathTbl.parsedAUsFile{i});
        break;  
    end
    
    load(pathTbl.cleanedAUsTblsFile{i}, 'removedRows');
    if isempty(removedRows)
        error('Failed to load removedRows from %s!\n', pathTbl.cleanedAUsTblsFile{i});
        break;  
    end
    
    try
        intensitiesTbl = getAUsIntensitiesFromXls(pathTbl.fullXlsFile{i}, removedRows);
        
        % Add the intensities column to already constructed tables
        if ~isempty(intensitiesTbl)
            AUs_all_tables = addIntensCol__2__AUs_all_tables__observ_tbl(AUs_all_tables,...
                AUs_summary_tbl, AUs_parsed_full_list, intensitiesTbl);

            AUs_all_tables = addIntensCol__2__AUs_all_tables__matchedTimes_tbl(AUs_all_tables);
        else
            fprintf('setupSyncAUsIntensitiesAndVid: no intensities found in %s \n', pathTbl.AUsFramesTblsFile{i});
        end

        
    catch ME
        warning('setupSyncAUsIntensitiesAndVid: failure while processing %s \n', pathTbl.AUsFramesTblsFile{i});
        rethrow(ME);
    end 

    
    save(pathTbl.AUsFramesTblsFile{i}, 'AUs_all_tables', '-append');
    fprintf('setupSyncAUsIntensitiesAndVid: AUs sync with frames intensities in %s completed successfully.\n', pathTbl.dataDir{i});
end



