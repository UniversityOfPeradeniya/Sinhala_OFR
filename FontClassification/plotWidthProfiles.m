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
    labels=[labels,files{i}];
    
    sizes = [sizes,size(char,1)];
    sizes2 = [sizes2,size(char,2)];
    %disp(files{i});
    %disp(size(char,2));
end

%disp(labels);
%disp(sizes);

scatter(sizes,sizes2,'filled');

return;
end

