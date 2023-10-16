function progress_bar(iterator,dot_div,step_div,steps,label)
%PROGRESS Prints simple progress info.

if mod(iterator,dot_div)==0
    fprintf(".")

end
if mod(iterator,step_div)==0
    fprintf("%s: %u/%u\n",label,iterator,steps);
end
end

