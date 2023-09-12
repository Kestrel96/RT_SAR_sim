function output = loadStructFromJson(filepath)

fid = fopen(filepath, 'r','n','UTF-8');

if fid == -1

    error('Unable to open file: %s\n', filepath);

end



raw = fread(fid, inf);

fclose(fid);



txt = char(raw');

output = jsondecode(txt);

end