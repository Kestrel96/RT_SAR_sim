classdef point_target
    %POINT_TARGET Summary of this class goes here
    %   Detailed explanation goes here

    properties
        x = 0;
        y = 0;
        r = 0;
        vr=0;
        refelctivity = 1;
        antenna_width = 0;
    end

    methods
        function obj = point_target(x,y)
            %POINT_TARGET Construct an instance of this class
            %   Detailed explanation goes here
            obj.x = x;
            obj.y = y;
        end
        function obj=get_vr(obj,vp,xp,yp)
            alfa=cot((xp-obj.x)/(yp-obj.y));
            obj.vr=vp*cos(alfa);


        end

        function obj=get_ant_width(obj,ant_angle)
            angle=deg2rad(ant_angle);
            obj.antenna_width = 2*obj.x*tan(angle/2);

        end

        function obj = get_inst_range(obj,v_radar,dt)
            obj.r=sqrt(obj.x^2+(obj.antenna_width/2-v_radar*dt)^2);
        end

        function obj = get_inst_range2(obj,radar_x,radar_y)

            obj.r=sqrt((obj.x-radar_x)^2+(obj.y-radar_y)^2);

        end

        function ilum = is_illuminated(obj,y_radar)
            if(obj.y <= y_radar+obj.antenna_width/2 && obj.y ...
                    >= y_radar-obj.antenna_width/2)
                ilum = true;
                return
            end


            ilum=false;



        end


        function beat = get_beat(obj,radar_y,Alfa,t,fc)
            %GET_BEAT Summary of this function goes here
            %   Detailed explanation goes here
            Beta=Alfa;
            lambda=0.3;
            T=1e-3;

            c=3e8;
            R=sqrt(obj.x^2+(obj.y-radar_y)^2);
            disp(R)
            tau=2*R/c;
            tau2=2*obj.x/c;



            beat=exp(2*pi*1i*(fc*tau+Alfa*tau*t-(Alfa*tau^2/2)));
            %beat=exp(2*pi*1i*(fc*tau+Alfa*tau*t));
            %beat=beat*exp(-2*pi*1i*(fc*tau));

            %RVP removal
            beat=beat*exp(2*pi*1i*(Alfa*tau^2/2));


            %%ti version
            %             f=Alfa*2*R/c;
            %             phi=4*pi*R/lambda;
            %             beat=exp(2*pi*1i*f*t+phi);


            %             c=3e8;
            %             phi=4*pi*R/lambda; % phase of IF signal
            %             %obj.r=obj.x;
            %             f_if=Beta*2*R/(T*c); % frequency of IF signal
            %             %r=f_if*T*c/(2*Beta);
            %             beat=obj.refelctivity* exp(1i*(2*pi*f_if*t+phi));
            %             %beat=exp(2*pi*1i*(Alfa*tau*t));


        end



        function point=get_point(obj)
            point=[obj.x,obj.y];
        end
    end
end


