function [  ] = characterReadInterface( dirName,pattern,sizeof )
%This will list all the png images in folder
%   And call the readChar function


files = dir( fullfile(dirName,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

data = cell(numel(files),1);                % store file contents
for i=1:numel(files)
    fname = fullfile(dirName,files{i});     % full path to file
    [pathstr, name, ~] = fileparts(fname);
    fpath = [pathstr,'\',name];
    disp(fpath);
    %emptyCenter(fpath,sizeof,pattern);
    pixelViseCompare(fpath,sizeof,pattern);
    
end
end

