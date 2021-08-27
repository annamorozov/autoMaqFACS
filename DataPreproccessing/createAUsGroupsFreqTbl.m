function groupsFreqTbl = createAUsGroupsFreqTbl(AUs_summary_tbl, groupSize)

% The function extracts all the possible groups of AUs of size [groupSize]
% and their frequencies. The function returns the frequencies table with
% the following columns: 'AU_names', 'AU_sumTblInd', 'AUs_title', 'groupsFreq'

groupsFreqTbl = [];
auColInd = 1:width(AUs_summary_tbl);

% Unique permutations of size [groupSize]
auColInd
uint16(groupSize)
if length(auColInd) < groupSize
    return
end

allIndGroups = nchoosek(auColInd ,uint16(groupSize));   

allIndGroups_rows = size(allIndGroups, 1);

groupsFreq = zeros(allIndGroups_rows, 1);
categoriesNames = cell(allIndGroups_rows, 1);
AusInRow = cell(allIndGroups_rows, groupSize);

for i=1:allIndGroups_rows    % iterate over all the groups
    jAuColFirst = [];
    jAuCol = [];
    Li_col1_in_col2 = [];
    
    for j=1:groupSize    % iterate over AUs within one group
        jInd = allIndGroups(i,j);
        jAuCol = AUs_summary_tbl{{'VidTimes'}, jInd}{:};
        jAuName = AUs_summary_tbl{{'OrigPtrn'}, jInd}{:};
        
        AusInRow{i,j} = jAuName;
        
        if j == 1
            % The name of the categories group shouldn't start from '&'
            categoriesNames{i} = sprintf('%s', jAuName);
            
            jAuColFirst = jAuCol;
            Li_col1_in_col2 = ones(size(jAuCol));
        end
        
        if j > 1
            categoriesNames{i} = sprintf('%s&%s', categoriesNames{i}, jAuName);
            
            % Check where the AU columns contain the same frame numbers.
            % The idea is to check the first column with all the others. 
            % Lia = ismember(A,B) returns an array containing logical 1 (true) where the data in A is found in B.
            Li_col1_in_col2_current = ismember(jAuColFirst,jAuCol);

            % Make the vectors the same length (pad with zeros at the end)
            maxLength = max([length(Li_col1_in_col2), length(Li_col1_in_col2_current)]);
            Li_col1_in_col2_current(length(Li_col1_in_col2_current)+1:maxLength, 1) = 0;
            Li_col1_in_col2(length(Li_col1_in_col2)+1:maxLength, 1) = 0;
            
            % If a frame number is contained in all the group AU columns, 
            % the AND operation should result with '1' 
            Li_col1_in_col2 = (Li_col1_in_col2 & Li_col1_in_col2_current);
        end

        if j == groupSize
            %fprintf('%d\n', i);
            groupsFreq(i) = sum(Li_col1_in_col2);
        end
    end
end

groupsFreqTbl = table(AusInRow, allIndGroups, categoriesNames, groupsFreq, 'VariableNames', {'AU_names', 'AU_sumTblInd', 'AUs_title', 'groupsFreq'});




