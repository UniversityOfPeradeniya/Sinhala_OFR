function [centerWidth] = centerLineWidth(dirName,pngFile,pattern)

close all;
disp(dirName);

wordbw = pngFile;


%get the center line

[height,width] = size(wordbw);

%disp(height);
%disp(width);

%center line is the half width

centerLine = round(height/2);

% figure;imagesc(wordbw);
% colormap gray;


%get the center line

centerData = wordbw(centerLine,:);

CC = bwconncomp(centerData);

%centerWidth = CC;

%sum of pixelIdlist lengths

totalSum = 0;

for(i=1:CC.NumObjects)
 
    totalSum = totalSum + size(CC.PixelIdxList{i},1);
    %disp(i);
end

%disp(totalSum);


centerWidth = totalSum/CC.NumObjects;
centerWidth = centerWidth/height;


return;





end

