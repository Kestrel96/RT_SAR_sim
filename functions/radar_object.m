classdef radar_object

    %RADAR Class representing a radar platform.
    %   Simple class for memory organization and basic calculations.

    properties
        c = 3e8;
         
        %radar position (in range)
        x = 0;
        % radar position (in azimuth)
        y = 0; 
        % platform velocity
        v = 10; 
        % Step length in azimuth direction for one pulse
        az_step= 0;

        % Maximum antenna length for maximum range
        max_ant_length = 0;
        % Upper antenna vertex in azimuth direction
        ant_y_upper = 0;
        % Lower antenna vertex in azimuth direction
        ant_y_lower = 0;
        % Range position of antenna (same as radar.x)
        ant_x = 0;
        % azimuth resolution (NEEDS REWORK)
        sigma_a; 
        % range resolution
        sigma_r;
        % antenna beam angle
        ant_angle = deg2rad(30); 
        % Wavelength
        lambda = 0; 

        % Raw data received from frontend
        SAR_raw_data = [];
        % Range compressed data
        SAR_range_compressed = [];
        % Range corrected data
        SAR_range_corrected = [];
        % Azimuth compressed data (final image)
        SAR_azimuth_compressed = [];
        % Azimuth reference chirp LUT for azimuth compression
        SAR_azimuth_reference_LUT = [];
        % Range doppler domain data for RCMC
        SAR_range_doppler=[];
        


    end

    methods

        function obj = radar_object(B, T, fc, v,PRI, ant_angle,max_fb)
            %RADAR Construct an instance of this class
            

            obj.v = v;
            obj.ant_angle = deg2rad(ant_angle);
            obj.sigma_r=obj.c/(2*B);
            obj.lambda = obj.c / fc;
            obj.az_step = PRI * obj.v;



        end


        function obj = get_ant_vertices(obj, max_distance)
            %GET_VERTICES Compute antenna vertices. Needs to be run before sensing.
            % Antenna is considered to be a triangle.

            L = 2 * max_distance * tan(obj.ant_angle / 2);
            obj.sigma_a=L/2;

            obj.ant_y_lower = obj.y - L / 2;
            obj.ant_y_upper = obj.y + L / 2;
            obj.ant_x = max_distance;
            obj.max_ant_length = L;

        end


    end
end

