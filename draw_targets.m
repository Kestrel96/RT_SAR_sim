hold on
for i=1:length(targets)
scatter(targets(i).x,targets(i).y,"x",'LineWidth',3);
txt=sprintf("Target %u",i);
text(targets(i).x+5,targets(i).y,txt);
end
hold off