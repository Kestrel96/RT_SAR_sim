params= loadStructFromJson("./radarParameters2.json");
raw_data=read_array("./data/raw_data_real_2.bin");
%raw_data=read_array("/home/kuba/Desktop/raw_data_real_2.bin");
raw_data = raw_data(:,1:2450);
% raw_data = raw_data(25000:50000,1:2450);

%raw_data=read_array("/home/kuba/RT_SAR_CUDA/data/dataset1/blocks/block2.bin");
