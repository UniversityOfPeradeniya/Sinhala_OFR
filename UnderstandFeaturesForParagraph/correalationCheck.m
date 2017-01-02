%this will check thie corrlation
close all;
clear all;
clc;
templatePath='1-9-6.png';
dirName = 'segmentedImages/0KDBOLIDDA/';
template = im2bw(imread(templatePath));


files = dir( fullfile(dirName,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

for i=1:numel(files)
    fname = fullfile(dirName,files{i});     % full path to file

imagePath=fname;
image   = im2bw(imread(imagePath));
%imshowpair(image,template,'montage')


c = normxcorr2(template,image);
%figure, surf(c), shading flat

[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);

hFig = figure('Name',files{i});
hAx  = axes;
imshow(image,'Parent', hAx);
imrect(hAx, [xoffSet+1, yoffSet+1, size(template,2), size(template,1)]);
title(num2str(max(c(:))))

disp([fname,' ',num2str(max(c(:)))])

end