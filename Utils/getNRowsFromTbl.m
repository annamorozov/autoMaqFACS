function resTbl = getNRowsFromTbl(tbl, rowsNum)

resTbl = [];

if height(tbl) > rowsNum
    len = height(tbl);
    step = int32(len/rowsNum);
    ind = 1:step:len;
    resTbl = tbl(ind, :);
else
    resTbl = tbl;
end
