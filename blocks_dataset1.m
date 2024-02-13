raw_data=raw_data(1:27000,:);
sweeps_per_block = 9000;


[sweeps,samples]=size(raw_data);
blocks=sweeps/sweeps_per_block;


for k=0:blocks-1
    
    start=1+k*sweeps_per_block;
    ending=sweeps_per_block+k*sweeps_per_block;
    block=raw_data(start:ending,:);
    path=sprintf("./data/dataset1/blocks/raw_data_1_block%i.bin",k);
    dump_array(path,block);

end

