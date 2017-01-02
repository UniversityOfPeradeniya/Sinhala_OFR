function [ ] = lowerHalfPixelCountChecker(inDir,outDir)

files = dir( fullfile(inDir,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

for i=1:numel(files)
    fname = fullfile(inDir,files{i});     % full path to file
    outputFullPath = [outDir,'\',files{i}];
    %disp(outputFullPath);
    %disp(fname);
    lowerHalfPixelCount(fname,outputFullPath,'');
    
end



end

