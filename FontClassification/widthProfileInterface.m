function [ ] = widthProfileInterface( dirName )
%This will execute plotWidthProfile for every directory inside the dirName
close all;

files = dir( fullfile(dirName) );   %list all *.png files
files = {files.name}';  
labelCollection = [];
sizesCollection = [];
sizes2Collection = [];
fontNameCollection = [];
%disp(files);

for i=1:numel(files)
    if(files{i}~='.')
        fname = fullfile(dirName,files{i});     % full path to file
        disp(fname);
        [ labels,sizes,sizes2 ] = plotWidthProfiles([fname,'\']);
        fontNameCollection = [fontNameCollection,files{i},char(10)]; %char(10) is the new line
        labelCollection = [labelCollection,labels,char(10)]; %char(10) is the new line
        sizesCollection = [sizesCollection,num2str(sizes,'%d,'),char(10)];
        sizes2Collection = [sizes2Collection,num2str(sizes2,'%d,'),char(10)];
    end
end

disp(fontNameCollection);
disp(labelCollection);
disp(sizesCollection);
disp(sizes2Collection);

fileID1 = fopen('fontNames.txt','w');
fprintf(fileID1,'%s',fontNameCollection);

fileID2 = fopen('labels.txt','w');
fprintf(fileID2,'%s',labelCollection);

fileID3 = fopen('size1.txt','w');
fprintf(fileID3,'%s',sizesCollection);


fileID4 = fopen('size2.txt','w');
fprintf(fileID4,'%s',sizes2Collection);


fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);

end

