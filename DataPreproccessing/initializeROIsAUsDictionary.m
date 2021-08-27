function AUsDict = initializeROIsAUsDictionary()

% Initialize AUs dictionaries

keySetUpper = {'1+2','6','7','41','43','45', '43_5'};
valueSetUpper = [1, 6, 7, 41, 43, 45, 435];
upperFaceAUsMap = containers.Map(keySetUpper,valueSetUpper);

keySetLower = {'25', '26', '27', '9', '10', '9+10', '12', '15', '16', '17', '18i', '18ii'};
valueSetLower = [25, 26, 27, 9, 10, 11, 12, 15, 16, 17, 18, 182];
lowerFaceAUsMap = containers.Map(keySetLower,valueSetLower);

keySetMiscel = {'8','19','38'};
valueSetMiscel = [8, 19, 38];
miscelAUsMap = containers.Map(keySetMiscel, valueSetMiscel);

keySetDismissed = {'3', '80', '181', 'EAD'};
valueSetDismissed = [3, 80, 181, 200];
dismissedAUsMap = containers.Map(keySetDismissed,valueSetDismissed);

AUsDict.upperFaceAUsMap = upperFaceAUsMap;
AUsDict.lowerFaceAUsMap = lowerFaceAUsMap;
AUsDict.dismissedAUsMap = dismissedAUsMap;
AUsDict.miscelAUsMap    = miscelAUsMap;


