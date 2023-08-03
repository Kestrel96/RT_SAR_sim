classdef point_target
    %POINT_TARGET Class representing a point target/reflector.

    properties
        %x coordinate (range)
        x = 0;
        %y coordinate (azimuth)
        y = 0;

        %Current range
        r = 0;
        %Current radial speed
        vr=0;
        %Reflectivity (can be used to attenuate the signal)
        refelctivity = 1;

        %Width of antenna at target range
        antenna_width = 0;
    end

    methods
        function obj = point_target(x,y)
            %POINT_TARGET Create point target at (x,y) coordinates.
            obj.x = x;
            obj.y = y;
        end


        function obj=get_vr(obj,vp,xp,yp)
            %GET_VR get radial speed of target.
            alfa=cot((xp-obj.x)/(yp-obj.y));
            obj.vr=vp*cos(alfa);


        end

        function obj=get_ant_width(obj,ant_angle)
            %GET_ANT_WIDTH Get antenna width at range pf the target.
            angle=deg2rad(ant_angle);
            obj.antenna_width = 2*obj.x*tan(angle/2);

        end


        function ilum = is_illuminated(obj,y_radar)
            %IS_ILLUMINATED Return true if target is within beam. Otherwise false.
            if(obj.y <= y_radar+obj.antenna_width/2 && obj.y ...
                    >= y_radar-obj.antenna_width/2)
                ilum = true;
                return
            end


            ilum=false;

        end


        function beat = get_beat(obj,radar_y,Alfa,t,fc)
            %GET_BEAT Return beat signal of a target.
            %   radar_y - azimuth position of radar platform
            %   Alfa    - Modulation rate
            %   t       - time vector
            %   fc      - carrier frequency


            c=3e8;
            R=sqrt(obj.x^2+(obj.y-radar_y)^2);
            tau=2*R/c;

            beat=exp(2*pi*1i*(fc*tau+Alfa*tau*t-(Alfa*tau^2/2)));
            beat=obj.refelctivity*beat;

        end



        function point=get_point(obj)
            %GET_POINT Return object position.
            point=[obj.x,obj.y];
        end
    end
end


