
function[i] = main (fileName,pageNumber)


%fileName = '0.png';
a = imread(fileName);
%a = imcrop(a);
a = imrotate(a,90);

padlength = 20; %length of padding of two sides


level = graythresh (a);
b = im2bw (a, level);

% Complement %
c = imcomplement (b);

%figure;imshow(c);
%define pad
image=padarray(c,[0 padlength]);
% figure;imshow(image);



%VP to crop out lines
verticalProjection = sum(image, 1);

% set(gcf, 'Name', 'Segmentation Trial', 'NumberTitle', 'Off') 
% subplot(2, 2, 1);imshow(image); 
% subplot(2,2,3);
% plot(verticalProjection, 'b-');

%process vertical projection

%first subtract the 5% of max value to remove the noise
verticalProjectionFiltered = verticalProjection - mean(mean(verticalProjection))*0.05;

verticalProjectionFiltered(verticalProjectionFiltered<0)=0;
verticalProjectionFiltered(verticalProjectionFiltered>0)=1;
% subplot(2,2,4);
% plot(verticalProjectionFiltered, 'b-');


%Now find connected regions to separate out lines

CC = bwconncomp(verticalProjectionFiltered);
S = regionprops(CC,'BoundingBox');

for i=1:numel(S)
    %disp(S(i).BoundingBox);
    rectangle = S(i).BoundingBox;
    portion = image(:,ceil(rectangle(1)):ceil(rectangle(1))+ceil(rectangle(3)));
    %figure;imshow(portion);
    %Now I can process this portion
    namePart = [num2str(pageNumber),'-',num2str(i),'-'];
    segment(portion,namePart);
    
end
%figure;imshow(S(1).Image);
%figure;imshow(S(2).Image);
%figure;imshow(S(3).Image);



return;
end