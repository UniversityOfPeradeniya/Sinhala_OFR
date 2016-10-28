function [ ] = projectionProfiles( fname,sizeofside,pattern )
%This will save the projection profiles into single vector
close all;
power = 1.5;
fileID = fopen([fname,pattern,'.txt'],'w');
char = imread([fname,'.png']);
char = imresize(char,[round(sizeofside/2),round(sizeofside/2)]);
char = im2bw(char);


char90 = imrotate(char,90);
char = imcomplement(char);
char90 = imcomplement(char90);


verticalProjection = sum(char, 1);
horizontalProjection = sum(char90,1);

verticalProjectionsum = sum(verticalProjection);
horizontalProjectionsum = sum(horizontalProjection);

verticalProjection = verticalProjection .* (verticalProjectionsum^power);
horizontalProjection = horizontalProjection .* (horizontalProjectionsum^power);

%writing pixel values as a vector

fprintf(fileID,'%f ',[verticalProjection,horizontalProjection]);
fprintf(fileID,'\n');
fclose(fileID);




end