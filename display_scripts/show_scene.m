scene_figure=figure('Name','Scene','NumberTitle','off','Position', [0 0 2000 1900]);


t=title("Scene Setup");
t.FontSize=18;
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=15;
lbl_x.FontWeight='bold';
lbl_y=ylabel("Azimuth Distance [m]");
lbl_y.FontSize=15;
lbl_y.FontWeight='bold';
hold on
for i=1:length(targets)
%% 
scatter(targets(i).x,targets(i).y,"o",'LineWidth',5);
txt=sprintf("Target %u",i);
text(targets(i).x+5,targets(i).y,txt,"FontSize",15,'Color','black',BackgroundColor='white');
end
hold off
xlim([params.centralSwathRange-params.swathWidth+200,params.centralSwathRange+params.swathWidth-200]);
ylim([-1,azimuth_distance+10]);
% h1 = axes;
% set(h1, 'Ydir', 'reverse')
% set(h1, 'YAxisLocation', 'Right')
ax = gca;
ax.FontWeight='bold';
ax.YDir= 'normal';

hold off
grid on


saveas(scene_figure,"./graphics/scene.png");
