function [density] = densityAnalyzer(fname,singlepngfile,pattern)
%This will analyze the density of the image and return save one file per
%folder

%disp(fname);
%disp(singlepngfile);

%open image

word = imread(singlepngfile);
if ~islogical(word)
    wordbw = im2bw(word);
else
    wordbw = word;
end
cb = sum(wordbw(:));
cw = numel(wordbw) - cb;
sizeofImage = numel(wordbw);
%disp(cw);
%disp(cb);
%disp(sizeofImage);

%now find the percentage of density
density = (cb/sizeofImage)*100;
disp(density);


%open the file
fileID = fopen([fname,'/',pattern,'.txt'],'a');
fprintf(fileID,'%.5f\n',density);
fclose(fileID);

return


end

