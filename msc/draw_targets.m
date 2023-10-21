hold on
for i=1:length(targets)
%% 
scatter(targets(i).x,targets(i).y,"o",'LineWidth',1);
txt=sprintf("Target %u",i);
text(targets(i).x+5,targets(i).y,txt);
end
hold off