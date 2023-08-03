function export_settings(fc,B,T,Alfa,ant_angle,v,PRI,PRF,max_range)
f= fopen('./data/radar_setup.txt','w');


fprintf(f,"fc=%f\n",fc);
fprintf(f,"B=%f\n",B);
fprintf(f,"T=%f\n",T);
fprintf(f,"Alfa=%f\n",Alfa);
fprintf(f,"ant_angle=%f\n",ant_angle);
fprintf(f,"v=%f\n",v);
fprintf(f,"PRI=%f\n",PRI);
fprintf(f,"PRF=%f\n",PRF);
fprintf(f,"max_range=%f\n",max_range);

fclose(f);


end
