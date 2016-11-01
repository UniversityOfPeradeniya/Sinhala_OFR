function [ output_args ] = groupSingleFolder( fpath,sizeof )
%This will group a single folder

%Processing png inside the folder
pngs = dir( fullfile(fpath,'*.png') );   %list all files
pngs = {pngs.name}';
pngList = cell(numel(pngs),1);

%open all the files in the image as grayscales
%add them together

charmain = uint32(zeros([round(sqrt(sizeof)),round(sqrt(sizeof))]));

%charmain = uint32(zeros([200,200]));


for i=1:numel(pngs)

    fullfilepath = fullfile(fpath,pngs{i});     % full path to folder
    [pathstr, name, ~] = fileparts(fullfilepath);
    newfpath = [pathstr,'\',name];
    disp(newfpath);
    
    char = imread([newfpath,'.png']);
    char = imcomplement(char);

    char = imresize(char,[round(sqrt(sizeof)),round(sqrt(sizeof))]);
    %imshow(char);
    
    %add each chars
    charmain = charmain+uint32(char);
end

%get the average
charmain = uint8(charmain/numel(pngs));

imshow(charmain);
disp(fpath);
imwrite(charmain,[fpath,'-average.png']);

end

