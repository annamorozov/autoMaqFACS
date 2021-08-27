function sumFreqTbl = sum2AUsGroupsFreqTbls(sumFreqTbl, AuGroupsFreqTbl, groupSize)

% Make AUs frequencies table of 2 tables: sumFreqTbl and AuGroupsFreqTbl

% Take only non-zero frequencies
nonZeroFreqInd = AuGroupsFreqTbl.groupsFreq > 0;
freqTbl = AuGroupsFreqTbl(nonZeroFreqInd, :);

% All the possible permutations of AUs (order) in a group of a given size
indOrders = perms(1:groupSize);   
indOrders_rows = size(indOrders, 1);

% iterate over rows of a single table
for i = 1:height(freqTbl)  
    % Itearte over different combinations (permutations) within AU groups
    % For example: [AU25, AU26] and [AU26, AU25]
    orderFound = false;
    j = 1;
    while (j <= indOrders_rows) && ~orderFound     
        % Order the AUs according to the current permutation
        orderedAUs = freqTbl.AU_names(i, indOrders(j,:));
        
        k = 1;
        while (k <= height(sumFreqTbl)) && ~orderFound
            % Compare the AUs row from [sumFreqTbl] to the permutation
            % [orderedAUs]
            sumFreqTblRow = sumFreqTbl.AU_names(k,:);
            diff = setdiff(sumFreqTblRow, orderedAUs);
            
            if isempty(diff)
                orderFound = true;
                sumFreqTbl.groupsFreq(k) = sumFreqTbl.groupsFreq(k) + freqTbl.groupsFreq(i);
            end
            
            k = k+1;
        end
        
        j = j+1;
    end
    
    if ~orderFound
        % If the row is not found, add the AUs group to sumFreqTbl
        row2Add = {freqTbl.AU_names(i, :), freqTbl.AUs_title(i), freqTbl.groupsFreq(i)};
        sumFreqTbl = [sumFreqTbl; row2Add];
    end
end

