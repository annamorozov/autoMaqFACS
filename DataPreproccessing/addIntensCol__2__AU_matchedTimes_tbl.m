function AU_matchedTimes_tbl = addIntensCol__2__AU_matchedTimes_tbl(AU_observ_tbl,...
    AU_matchedTimes_tbl)

%AU_observ_tbl = AUs_all_tables_new{1, 1}.AU_observ_tbl{1,1};
%AU_matchedTimes_tbl = AUs_all_tables_new{1, 1}.AU_matchedTimes_tbl{1,1};

[~,Loc_matchTbl] = ismember(AU_observ_tbl.Time_Relative_sf,...
    AU_matchedTimes_tbl.Observer_t);

len = length(AU_matchedTimes_tbl.Observer_t);
intensCol = cell(len, 1);

% Fill the intensities for the found observer times
for i = 1:length(AU_observ_tbl.Time_Relative_sf)
    intensCol(Loc_matchTbl(i)) = AU_observ_tbl.AU_intensities(i);
end

% Fill the intensities between the found observer times
for i = 1:length(AU_observ_tbl.Time_Relative_sf)-1
    intensCol(Loc_matchTbl(i):Loc_matchTbl(i+1)-1) =...
        deal(AU_observ_tbl.AU_intensities(i));
end

if height(AU_matchedTimes_tbl) ~= length(intensCol)
    error('Different length of AU_matchedTimes_tbl and intensCol');
end

AU_matchedTimes_tbl.AU_intensities = intensCol;

