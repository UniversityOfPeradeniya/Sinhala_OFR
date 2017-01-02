function [ ] = interface(dirName,outputDirName)
%interface will open all the png images in folder and segment them

%dirName = '';              %# folder path
files = dir( fullfile(dirName,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

data = cell(numel(files),1);                % store file contents
for i=1:numel(files)
    fname = fullfile(dirName,files{i});     % full path to file
    folderName = strsplit(files{i},'.pdf');
    outputFullPath = [outputDirName,'/',char(folderName(1)),'/'];
    disp(outputFullPath);
    disp(fname);
    main(fname,1,outputFullPath);        % run main
    %close all;
    
end


end

