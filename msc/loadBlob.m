function dataVector = loadBlob(filepath, datatype)

% if nargin < 2 || isempty(datatype)
%  
%      datatype = DEFAULT_DATATYPE;
%  
%  end


fid = fopen(filepath);

if fid == -1

    error('Failed loading file %s.', filepath);

end



data = fread(fid);

fclose(fid);



iseven = @(n) mod(n, 2) == 0;

assert(iseven(length(data)), 'Data length should be even.')



dataVector = data(1 : end / 2) + 1i * data(end / 2 + 1 : end);

% dataVector = data(1 : 2 : end) + 1i * data(2 : 2 : end);

end