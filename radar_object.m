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

        Beta = 0 % slope
        lambda = 0; % Wavelength
        ant_angle = deg2rad(30); % antenna beam angle
                sigma_a; % azimuth resolution
                 sigma_r;% range resolution
        v = 10; % platform velocity
        pulses = 1000;
        az_step = 0;

        SAR_raw_data = [];
        SAR_range_compressed = [];
        SAR_rage_corrected = [];
        SAR_azimuth_compressed = [];
        SAR_azimuth_reference_LUT = [];
        signal_length = 0;

        fs = 500e3; % ADC smapling rate

    end

    methods

        function obj = radar_object(B, T, fc, v,PRI, ant_angle)
            %RADAR Construct an instance of this class
            %   Detailed explanation goes here

            obj.v = v;
            obj.B = B;
            obj.T = T;
            obj.fc = fc;
            obj.ant_angle = deg2rad(ant_angle);

            
            obj.sigma_r=obj.c/(2*obj.B);

            obj.Beta = B / T;
            obj.lambda = obj.c / fc;
            obj.PRI=PRI;
            obj.az_step = obj.PRI * obj.v;
            

        end

        function outputArg = method1(obj, inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end

        function obj = get_fs(obj, max_distance)

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

        function obj = get_azimuth_reference(obj, max_range)

            % Range reference with 1 m intervals between targets
            for k = 1:max_range

                r = k;
                antenna_width = 2 * r * tan(obj.ant_angle / 2);
                antenna_width = floor(antenna_width);

                radar_azimuth = -antenna_width / 2;

                steps = 2 * max_range * tan(obj.ant_angle / 2) / obj.az_step;
                steps = floor(steps);

                no_sample_count = 0;

                reference=[];
                if (antenna_width >= 1)

                    inst_range = [];
                    no_sample_count = 0;

                    for l = 1:steps

                        if (radar_azimuth < antenna_width / 2)
                            inst_range(l) = sqrt(radar_azimuth ^ 2 + r ^ 2);
                            radar_azimuth = radar_azimuth + obj.az_step;


                        else
                            break
                            inst_range(l) = 997;
                            no_sample_count = no_sample_count + 1;
                        end

                    end

                else
                    inst_range = zeros(1, steps);

                end


                phase_shifts = 4 * pi * inst_range / obj.lambda;
                reference(1, :) = exp(1i * (phase_shifts));
                reference = reference(end:-1:1);
                reference = conj(reference);

                obj.SAR_azimuth_reference_LUT{k} = {reference};

            end

        end

        function obj=azimuth_compression(obj,samples)

            % get azimuth chirp signal
            faxis=0:obj.fs/samples:obj.fs-obj.fs/samples;
            raxis=faxis*obj.T*obj.c/(2*obj.Beta);




            for k=1:samples

                R=floor(raxis(k));
                if(R==0)
                    continue
                end

                if(R>numel(obj.SAR_azimuth_reference_LUT))
                    break;
                end
                azimuth_chirp=obj.SAR_range_compressed(:,k);
                gain=max(real(azimuth_chirp));
                azimuth_chirp=azimuth_chirp/max(azimuth_chirp);

                h=cell2mat(obj.SAR_azimuth_reference_LUT{R});

                w=blackman(length(h));
                h=h.*w';
                filtered=conv(h,azimuth_chirp);
                %delay output by timp/2
                A=length(h)/2;
                filtered=filtered(A:(end-A));
                filtered=filtered'*gain;




%                 if(k==281)
%                     close all
%                     figure
%                     tiledlayout(3,1)
%                     % plot(imag(chrp/max(chrp)))
%                     % hold on
%                     nexttile
%                     plot(raxis(1:length(azimuth_chirp)),real(azimuth_chirp));
%                     hold on
%                     plot(raxis(1:length(azimuth_chirp)),abs(filtered)/max(abs(filtered)),'-.','LineWidth',3);
%                     title("Range compressed data")
%                     xlabel("Range [m]")
%                     ylabel("Amplitude (normalized)")
%                     legend("Azimuth Chirp","Matched")
%                     %plot(abs(y));
%                     hold off
%                     title("azimuth chirp")
%                     %xlim([0,length(azimuth_chirp)])
%                     nexttile
%                     plot(real(h))
%                     hold on
%                     plot(w,'--')
%                 
%                     %xlim([0,length(azimuth_chirp)])
%                     title("Reference")
%                     legend("Azimuth Reference Function","Window (Blackmann)")
%                     hold off
% 
%                     nexttile
%                     plot(raxis(1:length(azimuth_chirp)),db(abs(filtered))-mean(db(abs(filtered))));
%                     title("Azimuth compressed")
%                     ylim([-10,150]);
%                     %xlim([0,length(azimuth_chirp)]);
% 
% 
% 
%                 end


                obj.SAR_azimuth_compressed(:,k)=abs(filtered);

            end

        end

    end

end

% determine max range (this range determines maximum length of returned signal)
% , antenna footprint, time of ilumination for every
% target
% get range to all targets
% Calculate 0 doppler frequnecy for each range
% star sensing - get beat signal from every target and mix it
% range compression - fft on every pulse - separate beat frequencies (skip
% phase for now)
% RCMC - perform for every tone
% Azimuth
