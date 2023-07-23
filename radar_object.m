classdef radar_object

    %RADAR Summary of this class goes here
    %   Detailed explanation goes here

    properties
        c = 3e8;

        x = 0; %radar position (in range)
        y = 0; % radar position (in azimuth)

        max_ant_length = 0;
        ant_y_upper = 0;
        ant_y_lower = 0;
        ant_x = 0;

        fc = 4e9; % carrier
        B = 25e6; % Bandwidth
        T = 5e-3; % Chirp time

        PRI = 5e-4;
        PRF=0;

        Beta = 0 % slope
        Alfa=0;
        lambda = 0; % Wavelength
        ant_angle = deg2rad(30); % antenna beam angle
        sigma_a; % azimuth resolution
        sigma_r;% range resolution
        v = 10; % platform velocity
        pulses = 1000;
        az_step = 0;

        SAR_raw_data = [];
        SAR_range_compressed = [];
        SAR_range_corrected = [];
        SAR_azimuth_compressed = [];
        SAR_azimuth_reference_LUT = [];
        SAR_range_doppler=[];
        signal_length = 0;

        fs = 500e3; % ADC smapling rate

    end

    methods

        function obj = radar_object(B, T, fc, v,PRI, ant_angle,max_fb)
            %RADAR Construct an instance of this class
            

            obj.v = v;
            obj.B = B;
            obj.T = T;
            obj.fc = fc;
            obj.ant_angle = deg2rad(ant_angle);


            obj.sigma_r=obj.c/(2*obj.B);

            obj.Beta = B / T;
            obj.Alfa=obj.Beta;
            obj.lambda = obj.c / fc;
            obj.PRI=PRI;
            obj.az_step = obj.PRI * obj.v;
            obj.PRF=1/PRI;
            obj.fs=max_fb*5;


        end

        function obj = get_fs(obj, max_distance)
            %GET_FS Get ADC sampling frequnecy based on maximum expected beat frequency.
            %max_distance - maximum expected distance

            f_max = obj.Beta * 2 * max_distance / (obj.T * obj.c);
            obj.fs = 3 * f_max;
        end

        function max_sig_length = get_max_signal_length(obj, max_distance)

            max_distance = max_distance + 5;
            f_max = obj.Beta * 2 * max_distance / (obj.T * obj.c);
            max_sig_length = 3 * f_max * obj.PRI;
            obj.signal_length = max_sig_length;

        end

        function obj = get_ant_vertices(obj, max_distance)

            L = 2 * max_distance * tan(obj.ant_angle / 2);
            obj.sigma_a=L/2;

            obj.ant_y_lower = obj.y - L / 2;
            obj.ant_y_upper = obj.y + L / 2;
            obj.ant_x = max_distance;
            obj.max_ant_length = L;

        end

        
        function obj=export_settings(obj)
            f= fopen('./data/radar_setupp.txt','w');

            fprintf(f,"fc=%f",obj.fc);
            fprintf(f,"B=%f",obj.B);
            fprintf(f,"T=%f",obj.T);
            fprintf(f,"Alfa=%f",obj.Alfa);
            fprintf(f,"ant_angle=%f",obj.ant_angle);
            fprintf(f,"v=%f",obj.v);
            fprintf(f,"PRI=%f",obj.PRI);
            fprintf(f,"PRF=%f",obj.PRF);
            fprintf(f,"max_range=%f",obj.max_range);

            close(f);


        end



    end
end

