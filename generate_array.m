N = 15000; % Number of rows
M = 2500; % Number of columns
startValue = 2; % Starting point for the linear progression
increment = 2; % Increment value

rowVector = startValue:increment:(startValue + (M-1)*increment);
resultArray = repmat(rowVector, N, 1);
imagesc(db(resultArray))

dump_array("/home/kuba/RT_SAR_CUDA/test_data/lin_row.bin",resultArray);