raw_data=read_array("./data/raw_data_real_2.bin");
kernel_lenght = 1000;

%%
raw_data=raw_data(1:50000,:);
sweeps_per_block = 9000;


[sweeps,samples]=size(raw_data);
blocks=sweeps/sweeps_per_block;

block =[];
for k=0:blocks-1
    
    start=1+k*sweeps_per_block;
     if k < blocks-1
         ending=sweeps_per_block+k*sweeps_per_block+kernel_lenght;
         block=raw_data(start:ending,:);

     else
         ending=sweeps_per_block+k*sweeps_per_block;
         block=raw_data(start:ending,:)+zeros(1,kernel_lenght);
     end
    %ending=sweeps_per_block+k*sweeps_per_block+kernel_lenght;
    path=sprintf("./data/dataset2_ov/blocks/block%i.bin",k);
    dump_array(path,block);

end

