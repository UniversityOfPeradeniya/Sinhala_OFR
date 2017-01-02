function [] = resizeWords(inFolder,outFolder)
%This will read all the files and resize them
close all;
height = 40;

files = dir( fullfile(inFolder) );   %list all dirs
files = {files.name}';                      % file names

disp(files);

%making directoris in outputFolder

for i=3:numel(files)
mkdir(outFolder,char(files{i}));
end

for i=3:numel(files)
    fname = fullfile(inFolder,files{i});     % full path to file
    outFolderCreated = fullfile(outFolder,files{i});
    disp(fname);
    %now take images in that folder
    pngfiles = dir( fullfile(fname,'\\','*.png') );   %list all *.png files
    pngfiles = {pngfiles.name}';% file names
    %disp(pngfiles);
    for j=1:numel(pngfiles)
        pngfile = pngfiles{j};
        singlePng = char(fullfile(fname,'\\',pngfile));
        outpngName = char(fullfile(outFolderCreated,'\\',pngfile));
        disp(singlePng);
        %disp(outpngName);
        outWord = cropWord(singlePng,height);
        %disp(outWord);
        if(~isnan(outWord))
            imwrite(outWord,outpngName);
            %disp(outWord);
        end
    end
    %outWord = cropWord(singlePng,height);
    
end





end

