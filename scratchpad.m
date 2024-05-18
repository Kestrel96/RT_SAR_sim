C=10;
R=15;

test_data = zeros(C,R);
test_data_trans=zeros(R,C);

test_data(1,:)=2;
test_data(9,:)=3;
%imagesc(test_data);

 %   current_row = blockIdx.y;
%    current_column = blockIdx.x * blockDim.x + threadIdx.x;


current_row=[];
current_column=[];
for k=1:R*C

    current_column=mod(k,R)+1;
    current_row = floor(k/C)+1;

    transposed_column = mod(k,C)+1;
    transposed_row = floor(k/C)+1;

    test_data(current_column,current_row) = 1;

end

imagesc(test_data);
