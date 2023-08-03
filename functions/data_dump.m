function data_dump(path,data)
%DATA_DUMP Summary of this function goes here
%   Detailed explanation goes here

f= fopen(path,'wb');

[rows,cols]=size(data);
fwrite(f,[rows,cols],'uint');

for i=1:rows
    fwrite(f,real(data(i,:)),'single');

end

for i=1:rows
    fwrite(f,imag(data(i,:)),'single');

end

fclose(f);
end

