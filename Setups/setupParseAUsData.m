function setupParseAUsData(pathTbl, xlsType)
% Parse the AUs labeling data from xls files exported from Observer
% xlsType: 1 = full, 2 = short

tblFileCol = {};
switch xlsType
   case 1
       tblFileCol = pathTbl.fullXlsFile;
   case 2
       tblFileCol = pathTbl.shortXlsFile;
   otherwise
      error('xlsType musy be either 1 (full) or 2 (short)');
end

for i = 1:height(pathTbl)
    outputFolder = pathTbl.parsedAUsDir{i};
    
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end
    
    % Clean the tables
    [cleanXlsTbl, removedRows] = cleanAUsXls(tblFileCol{i});
    save(fullfile(outputFolder,'CleanedTbls.mat'),'cleanXlsTbl','removedRows');
    fprintf('setupParseAUsData: cleaning of data in %s completed successfully.\n', tblFileCol{i});
    
    % Get AUs from the tables
    
    % TODO: rename AUs_freq_tbl to AUs_observ_freq_tbl - these tables don't consider AU durations! 
    [AUs_freq_tbl, AUs_parsed_full_list] = getAUsFreqTbl(cleanXlsTbl);
    save(fullfile(outputFolder,'ParsedAUs.mat'),'AUs_freq_tbl','AUs_parsed_full_list');
    fprintf('setupParseAUsData: AUs parsing from %s completed successfully.\n', tblFileCol{i});
end
