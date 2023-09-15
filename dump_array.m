function dump_array(path,array)
%DUMP_ARRAY Summary of this function goes here
%   Detailed explanation goes here
f= fopen(path,'wb');

[rows,columns]=size(array);


fwrite(f,[rows,columns],'uint');

fprintf("Dumping %-40s ",path)

for i=1:rows
    fwrite(f,real(array(i,:)),'single');
    

end
fprintf("-")

for i=1:rows
    fwrite(f,imag(array(i,:)),'single');
    

end
fprintf("-")
fclose(f);

fprintf("> Done.\n")
end

