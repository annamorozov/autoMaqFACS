function AUs_all_tables = ...
    addIntensCol__2__AUs_all_tables__observ_tbl(AUs_all_tables, AUs_summary_tbl,...
    AUs_parsed_full_list, intensitiesTbl)
% Add the intencities column to the already constructed AUs tables

for i = 1:width(AUs_summary_tbl)
    
    % find the occurances of this AU in the xls table
    nameAU = AUs_summary_tbl{'OrigPtrn', i};
    rows = strcmp(AUs_parsed_full_list, nameAU);
    
    % intensities of this particular AU
    AU_intensities_col = intensitiesTbl{rows,:};    
    
    if iscell(AUs_all_tables{i}.AU_observ_tbl)
        
        if height(AUs_all_tables{i}.AU_observ_tbl{:}) ~= length(AU_intensities_col)
            error('Different length of AU_observ_tbl column and AU_intensities_col for AU %s', nameAU);
        end
        
        AUs_all_tables{i}.AU_observ_tbl{:}.AU_intensities = AU_intensities_col;
        
    else %  AUs_all_tables{i}.AU_observ_tbl is table
        if height(AUs_all_tables{i}.AU_observ_tbl) ~= length(AU_intensities_col)
            error('Different length of AU_observ_tbl column and AU_intensities_col for AU %s', nameAU);
        end
        
        AUs_all_tables{i}.AU_observ_tbl.AU_intensities = AU_intensities_col;
    end
 
end
