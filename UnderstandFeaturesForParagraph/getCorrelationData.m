function [maxCorrelations] = getCorrelationData(singlepngfile,pattern)
%This will check the correlation with specific set of templates
%currenly I will limited to and hardcode to 10

close all;

wordbw = singlepngfile;

path = 'correlatedTemplatesNew\';
maxCorrelations = [];

files = dir( fullfile(path,'*.png') );   %list all *.png files
files = {files.name}';                      % file names
%disp(files);
for i=1:numel(files)
    fname = fullfile(path,files{i});     % full path to file
    tmp = im2bw(imread(fname));
    C = NaN;
    %check the sizes
    if(size(wordbw,1)>=size(tmp,1) && size(wordbw,2)>=size(tmp,2))
        C = max(max(normxcorr2(tmp, wordbw)));
        
        %disp(C);
    end
    maxCorrelations = [maxCorrelations,C];
    
end

return

end

