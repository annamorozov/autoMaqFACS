function map = getRelevantAUsMap(AUsColDict, AU_Name)  

map = {};

if isKey(AUsColDict.upperFaceAUsMap,     AU_Name)
    map = AUsColDict.upperFaceAUsMap;
elseif isKey(AUsColDict.lowerFaceAUsMap, AU_Name)
    map = AUsColDict.lowerFaceAUsMap;
elseif isKey(AUsColDict.dismissedAUsMap, AU_Name)
    map = AUsColDict.dismissedAUsMap;
elseif isKey(AUsColDict.miscelAUsMap,    AU_Name)
    map = AUsColDict.miscelAUsMap;
else
    error('AU name %s is not a key in any of the AUsColDict maps!', AU_Name);
end