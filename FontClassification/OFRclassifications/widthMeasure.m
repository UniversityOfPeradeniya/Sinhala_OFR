function [  ] = widthMeasure(fname,pattern)
%Save the width

char = imread([fname,'.png']);
char = imcomplement(char);


fileID = fopen([fname,pattern,'.txt'],'w');


charvector = size(char,2);

%writing pixel values as a vector
fprintf(fileID,'%d ',charvector);
fprintf(fileID,'\n');
fclose(fileID);
return;


end

