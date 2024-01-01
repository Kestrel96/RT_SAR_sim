function data = read_array(filepath)
%READ_ARRAY Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(filepath);

if fid == -1

    error('Failed loading file %s.', filepath);

end

fprintf("Reading %s\n",filepath);

rows=fread(fid,1,"uint32");
columns=fread(fid,1,"uint32");


real_parts=fread(fid,rows*columns,"float32");
imag_parts=fread(fid,rows*columns,"float32");

data=zeros(rows,columns);

for l=1:rows
    
    start=1+(l-1)*columns;
    stop=start-1+columns;


        data(l,:)=real_parts(start:stop)+1i*imag_parts(start:stop);

end




end

