function AUsColDict = initializeROIsAUsColDictionary()

keySetUpper = {'AU_1_2','AU_6','AU_7','AU_41','AU_43','AU_45', 'AU_43_5'};
valueSetUpper = [1, 6, 7, 41, 43, 45, 435];
upperFaceAUsMap = containers.Map(keySetUpper,valueSetUpper);

keySetLower = {'AU_25', 'AU_26', 'AU_27', 'AU_9', 'AU_10', 'AU_9_10', 'AU_12',...
    'AU_15', 'AU_16', 'AU_17', 'AU_18i', 'AU_18ii',...
    'AU_25_AU_26', 'AU_25_AU_26_AU_16', 'AU_25_AU_26_AU_18i'};
valueSetLower = [25, 26, 27, 9, 10, 11, 12, 15, 16, 17, 18, 182, 256, 257, 258];
lowerFaceAUsMap = containers.Map(keySetLower,valueSetLower);

keySetMiscel = {'AU_8','AU_19','AU_38'};
valueSetMiscel = [8, 19, 38];
miscelAUsMap = containers.Map(keySetMiscel, valueSetMiscel);

keySetDismissed = {'AU_3', 'AU_80', 'AU_181', 'AU_EAD'};
valueSetDismissed = [3, 80, 181, 200];
dismissedAUsMap = containers.Map(keySetDismissed,valueSetDismissed);

AUsColDict.upperFaceAUsMap = upperFaceAUsMap;
AUsColDict.lowerFaceAUsMap = lowerFaceAUsMap;
AUsColDict.dismissedAUsMap = dismissedAUsMap;
AUsColDict.miscelAUsMap    = miscelAUsMap;