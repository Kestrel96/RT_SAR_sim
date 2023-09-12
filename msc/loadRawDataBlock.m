function [rawData, radarParameters] = loadRawDataBlock(rawDataFilepath, radarParametersFilepath)

rawDataVector = loadBlob(rawDataFilepath);

radarParameters = loadStructFromJson(radarParametersFilepath);



numberOfSweeps = length(rawDataVector) / (radarParameters.samplesPerSweep);

isinteger = @(x) floor(x) == x;

assert(isinteger(numberOfSweeps));

rawData = reshape(rawDataVector, radarParameters.samplesPerSweep, numberOfSweeps);

end