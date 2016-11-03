
function[] = main (fileName)
close all;
clc;

%fileName = '0.png';
a = imread(fileName);
%a = imcrop(a);
a = imrotate(a,90);
widthofSpace = 50; %50px space between spaces
padlength = 20; %length of padding of two sides
threshold = 0;

level = graythresh (a);
b = im2bw (a, level);

% Complement %
c = imcomplement (b);

%define pad
i=padarray(c,[0 padlength]);




%VP
verticalProjection = sum(i, 1);

%set(gcf, 'Name', 'Segmentation Trial', 'NumberTitle', 'Off') 
%subplot(2, 2, 1);imshow(i); 
%subplot(2,2,3);
%plot(verticalProjection, 'b-');

%process vertical projection

windows = zeros(1,padlength);
arrayLen = numel(verticalProjection);
idx = padlength;
start = false;
while idx < arrayLen-padlength
    
    element = verticalProjection(idx);
    %disp(element);
    sumofElements = sum(verticalProjection(idx-floor(padlength/2):idx+floor(padlength/2)));
    %disp(sumofElements);
    windows = [windows,sumofElements];
    idx=idx+1;
end
%figure,plot(windows, 'g-');


idx = 1;
lines = [];
image = [];
started = false;
count = strrep(fileName, '.png', ''); %convert filename into number
passCounter = 0;
while idx<length(windows)
    
    if(windows(idx)>threshold && ~started)
        image = [image,idx];
        started = true;
    end
    if(windows(idx)<=threshold && started)
         image=[image,idx];
         started = false;
         disp(image);
         lines = [lines;image];
         %figure,imshow(i(:,image(1):image(2)));
         
         %for each image call the segment function
         oneLine = i(:,image(1):image(2));
         originalLine = imrotate(oneLine,-90);
         passNo = [count,num2str(passCounter)];
         %disp('passNo');
         %disp(passNo);
         segment(originalLine,passNo);
         passCounter = passCounter+1;
         image = [];
         
    end
    idx = idx+1;
end

return;
end