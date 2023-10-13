function [frequency] = dist2freq(distance,Alfa)
%DIST2FREQ Convert distance to beat frequency.

        c=3e8;
        frequency=distance*(2*Alfa)/c;
end

