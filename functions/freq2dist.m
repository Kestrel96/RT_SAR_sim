function [distance] = freq2dist(frequency,Alfa)
%FREQ2DIST Convert frequency [Hz] to distance [m]

        c=3e8;
        distance=frequency*c/(2*Alfa);
end

