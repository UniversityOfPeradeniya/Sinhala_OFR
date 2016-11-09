function [ labels,sizes,sizes2 ] = plotWidthProfiles(dirName)
%This will plot the width profiles to see


files = dir( fullfile(dirName,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

data = cell(numel(files),1);                % store file contents

labels = [];
sizes = [];
sizes2 = [];
for i=1:numel(files)
    fname = fullfile(dirName,files{i});     % full path to file
    char = imread(fname);
    labels=[labels,files{i},','];
    
    sizes = [sizes,size(char,1)];
    sizes2 = [sizes2,size(char,2)];
    %disp(files{i});
    %disp(size(char,2));
end

%disp(labels);
%disp(sizes);

figure;scatter(sizes,sizes2,'filled');

%save arrays in a file
% fileID = fopen('scatterData.txt','w');
% fprintf(fileID,'%d,',sizes);
% fprintf(fileID,'\n');
% fprintf(fileID,'%d,',sizes2);
% fprintf(fileID,'\n');
% fprintf(fileID,'%s',labels);
% fprintf(fileID,'\n');
% fclose(fileID);

return;
end

