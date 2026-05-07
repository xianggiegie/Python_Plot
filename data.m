clc;
clear all;
fild = fopen('data.coe','wt');
fprintf(fild,'%s\n','MEMORY_INITIALIZATION_RADIX=10;');
fprintf(fild,'%s\n','MEMORY_INITIALIZATION_VECTOR=');
for j = 0 : 255
	if(j == 255)
		fprintf(fild,'%g;',j);
	end
	if(j<255)
		fprintf(fild,'%g,\n',j);
	end
end
fclose(fild);