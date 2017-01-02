

%open reference image
clc;
clear all;
close all;
fontFolder = 'charImages/ya/';
resizeFactor = [20,20];

%ref = im2bw(imcomplement(imread('charImages/ya/140.png')));
%ref = imresize(ref,resizeFactor);
ref = circularFeatures360FromCornersToNearest('charImages/ya/140.png');

files = dir( fullfile(fontFolder,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

for i=1:numel(files)
    fname = fullfile(fontFolder,files{i});     % full path to file
    
    current = circularFeatures360FromCornersToNearest(fname);
    
    difference = ref-current;
    similarity = sqrt(sum(sum(power(difference,2))));
    disp([files{i},',',num2str(similarity)]);
    %resize this to 
    %imshow(current);
    
    %close all;
    %disp(fname);
end

