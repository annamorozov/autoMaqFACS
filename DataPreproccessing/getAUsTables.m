function [AUs_summary_tbl, AUs_all_tables, formatted_xls_data] = getAUsTables(clean_xls_data, AUs_freq_tbl, AUs_parsed_full_list, vidTimesVec)

% Output: 
% AUs_summary_tbl - overview of all AUs (including frames numbers)
% AUs_all_tables - 2 detailed tables for each AU (times from observer, times from video, errors test etc.)


% create a table with headers = AU names
header = cell(1,size(AUs_freq_tbl,1));
for i=1:size(AUs_freq_tbl,1)
    header(1,i) = strcat('AU_', AUs_freq_tbl.AU_Name(i));
    
    % replace "+" to "_" in the header
    if ~isvarname(header(1,i))
        header(1,i) = matlab.lang.makeValidName(header(1,i));
    end
end

% Table with column for each AU
AUs_summary_tbl  = cell2table(cell(1,size(AUs_freq_tbl,1)), 'VariableNames', cellstr(header)');
AUs_summary_tbl{1,:} = AUs_freq_tbl.AU_Name(:)';
AUs_summary_tbl.Properties.RowNames(1) = {'OrigPtrn'};

% Add AU parsed names column
xls_data = [clean_xls_data cell2table(AUs_parsed_full_list(:), 'VariableNames', cellstr('Behavior_filtered'))];

AUs_all_tables = cell(size(AUs_freq_tbl,1),1);
error_row = zeros(1, size(AUs_freq_tbl,1));
times_row = cell(1, size(AUs_freq_tbl,1));
count_row = zeros(1, size(AUs_freq_tbl,1));
    
% find the occurances of this AU in the xls table
for i = 1:size(AUs_freq_tbl.AU_Name,1)
    rows = strcmp(xls_data.Behavior_filtered, AUs_freq_tbl.AU_Name{i}); 
    AU_observ_tbl = xls_data(rows,:);        % table of this particular AU

    AU_matchedTimes_tbl = getAuAllTimes(AU_observ_tbl, vidTimesVec);
    
    AU_cell = {AU_observ_tbl, AU_matchedTimes_tbl};
    AUs_all_tables{i} = cell2table(AU_cell, 'VariableNames', {'AU_observ_tbl', 'AU_matchedTimes_tbl'});
    
    % additional summary rows
    error_row(i) = any(AU_matchedTimes_tbl.Error);
    times_row{i} = {unique(AU_matchedTimes_tbl.Frame_n(:))};    %Attention: here the frames filtered to unique
    count_row(i) = size(times_row{i}{:},1);
end

% add the additional summary rows to the table
AUs_summary_tbl = [AUs_summary_tbl; array2table(error_row, 'VariableNames', cellstr(header)'); ...
    cell2table(times_row, 'VariableNames', cellstr(header)'); ...
    array2table(count_row, 'VariableNames', cellstr(header)')];

AUs_summary_tbl.Properties.RowNames(2) = {'Error'};
AUs_summary_tbl.Properties.RowNames(3) = {'VidTimes'};
AUs_summary_tbl.Properties.RowNames(4) = {'Count'};

% sort the tables columns according to the count row (first column is the most frerquent)
[~,Ind] = sort(cell2mat(AUs_summary_tbl{4,:}),'descend');
AUs_summary_tbl = AUs_summary_tbl(:,Ind);
AUs_all_tables = AUs_all_tables(Ind,:);

formatted_xls_data = xls_data;



























