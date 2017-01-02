function [retvalue] = lowerHalfPixelCount(pngFile,outDirName,pattern)

close all;
disp(outDirName);

wordbw = pngFile;


%get the center line

[height,width] = size(wordbw);

%disp(height);
%disp(width);

%center line is the half width

centerLine = round(height/2);


lowerHalf = wordbw(centerLine:height,:);

%imagesc(lowerHalf);
%colormap gray;

%get the vertical projection

VP = sum(lowerHalf,2);

%figure;plot(VP);

%get the max of second derivation
[M,I] = max(diff(diff(VP)));
I = I+2; %because second dreivation
if(I>size(VP,1))
    I = size(VP,1);
end


%disp(I);


lowerImage = lowerHalf(1:I,:);
%figure;imagesc(lowerImage);
%imwrite(lowerImage,outDirName);


%get the pixel density

density  = sum(sum(lowerImage))/ (size(lowerImage,1)*size(lowerImage,2));
%disp(density);


%Iterate throught the lowerImage 

%get the horizontal projection

HP = sum(lowerImage,1);
diffHP = diff(HP); %get the first derivative
%disp(HP);
%disp(diffHP);
[x,y] = size(lowerImage);
[xdiff,ydiff] = size(diffHP);
array = [];
for(i=1:ydiff)
 
 strip = lowerImage(:,i+1); %since diffHP is one less than the lowerImage
 %disp(strip);
 %get the connected components
 
 if(diffHP(i)==0 && HP(i+1)>1)
 
     s  = regionprops(strip,'Area');
     %disp([x]);
     allArea = cat(2, s.Area);
     array = [array,allArea];
     %disp(i+1);
 end
 
    
end
%disp(array);
%disp(x);
if(isnan(density) || isnan(mean(array)/x))
    retvalue = [0 0];
else
    retvalue = [density,mean(array)/x];
end

disp(retvalue);

end

