function [ ] = GetAveragePerFolder(dirName,sizeof)
%Get the average image of folders
%Before getting the average, this will resize the images


files = dir( fullfile(dirName) );   %list all folders
files = {files.name}';                      % folder names

data = cell(numel(files),1);                % store folder contents
for i=1:numel(files)
    
    if(files{i}~='.')
        fname = fullfile(dirName,files{i});     % full path to folder
        [pathstr, name, ~] = fileparts(fname);
        fpath = [pathstr,'\',name];
        disp(fpath);
        groupSingleFolder(fpath,sizeof);
        
    end
    
end



end

