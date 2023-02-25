function beat = get_beat(r,t,lambda,Beta,T)
%GET_BEAT Summary of this function goes here
%   Detailed explanation goes here

    c=3e8;
 
 phi=4*pi*r/lambda; % phase of IF signal
 %r=10;
 f_if=Beta*2*r/(T*c); % frequency of IF signal
 %r=f_if*T*c/(2*Beta);
 beat=exp(1i*(2*pi*f_if*t+phi));



end

