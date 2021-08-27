function AUs_all_tables = ...
    addIntensCol__2__AUs_all_tables__matchedTimes_tbl(AUs_all_tables)

for i = 1:length(AUs_all_tables)
    
    if iscell(AUs_all_tables{i}.AU_observ_tbl)
        
        AU_observ_tbl = AUs_all_tables{i}.AU_observ_tbl{:};
        AU_matchedTimes_tbl = AUs_all_tables{i}.AU_matchedTimes_tbl{:};
        
        AU_matchedTimes_tbl = addIntensCol__2__AU_matchedTimes_tbl(AU_observ_tbl,...
            AU_matchedTimes_tbl);
        AUs_all_tables{i}.AU_matchedTimes_tbl{:} = AU_matchedTimes_tbl;
       
    else % AUs_all_tables{i}.AU_observ_tbl is a table
        
        AU_observ_tbl = AUs_all_tables{i}.AU_observ_tbl;
        AU_matchedTimes_tbl = AUs_all_tables{i}.AU_matchedTimes_tbl;
        
        AU_matchedTimes_tbl = addIntensCol__2__AU_matchedTimes_tbl(AU_observ_tbl,...
            AU_matchedTimes_tbl);
        AUs_all_tables{i}.AU_matchedTimes_tbl = AU_matchedTimes_tbl;
        
    end
    
end
