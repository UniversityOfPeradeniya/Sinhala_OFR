function [ ] = getSURFfeatures(direcotry,outDir)
%This will find the SURF features in a folder
close all;
pngfiles = dir( fullfile(direcotry,'\\','*.png') );   %list all *.png files
pngfiles = {pngfiles.name}';% file names
figure;hold on;
for j=1:numel(pngfiles)
        singlepngfile = fullfile(direcotry,pngfiles{j});
        disp(singlepngfile);
        img = imread(singlepngfile);
        points = detectSURFFeatures(img);
        if(points.Count>10)
        disp(points.selectStrongest(2).Location);
        plot(points.selectStrongest(2));
        end

end

hold off;
print([outDir,'.pdf'],'-dpdf');

end

