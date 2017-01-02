function [ ] = interface(dirName)
%interface will open all the png images in folder and segment them

%dirName = '';              %# folder path
files = dir( fullfile(dirName,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

data = cell(numel(files),1);                % store file contents
for i=1:numel(files)
    fname = fullfile(dirName,[num2str(i-1),'.png']);     % full path to file
    disp(fname);
    main(fname,i);        % run main
    %close all;
    
end


end

